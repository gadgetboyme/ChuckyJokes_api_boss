import 'package:api_calls_boss/blocs/chuckCategoryBloc.dart';
import 'package:api_calls_boss/models/chuckCategories.dart';
import 'package:api_calls_boss/networking/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'chuckJokeView.dart';

class GetChuckCategories extends StatefulWidget {
  @override
  _GetShaftsState createState() => _GetShaftsState();
}

class _GetShaftsState extends State<GetChuckCategories> {
  ChuckCategoryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ChuckCategoryBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Chucky Categories',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.purple,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchCategories(),
        child: StreamBuilder<Response<ChuckCategories>>(
          stream: _bloc.chuckListStream,
          builder: (context, snapshot){
            switch(snapshot.data.status){
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                return CategoryList(categoryList: snapshot.data.data);
                break;
              case Status.ERROR:
                return Error(errorMessage: snapshot.data.message, onRetryPressed: () => _bloc.fetchCategories());
                break;
            }
            return Container();
          },
          
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }


}

class CategoryList extends StatelessWidget {
  final ChuckCategories categoryList;

  const CategoryList({Key key, this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 1.0,
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ShowChuckyJoke(categoryList.categories[index])));
                  },
                  child: Card(
                    margin: EdgeInsets.all(16),
                    // height: 65,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      color: Colors.purple,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: Text(
                          categoryList.categories[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto'),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  )));
        },
        itemCount: categoryList.categories.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
