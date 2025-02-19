import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiPage extends StatelessWidget {
  const ApiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Page'),
      ),
      body: PostListsFromAPI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PostListsFromAPI extends StatefulWidget {
  const PostListsFromAPI({super.key});

  @override
  State<PostListsFromAPI> createState() => _PostListsFromAPIState();
}

class _PostListsFromAPIState extends State<PostListsFromAPI> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPost();
  }

  Future<List<Post>> fetchPost() async {
    final response = await http
        .get(Uri.parse('https://6767d3e0c1de2e6421c85934.mockapi.io/todo'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      debugPrint(jsonResponse.toString());
      return jsonResponse.map((data) => Post.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: futurePosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final post = snapshot.data![index];
              return ListTile(
                title: Text(post.title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdatePostPage(
                        post: post,
                      ),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deletePost(post.id).then((_) {
                      setState(() {
                        futurePosts = fetchPost();
                      });
                    });
                  },
                ),
              );
            },
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }

  Future<void> deletePost(String id) async {
    String apiMasRifqy = "https://6767d3e0c1de2e6421c85934.mockapi.io/todo";
    final response = await http.delete(
      Uri.parse('$apiMasRifqy/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}

class CreatePostPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  Future<Post> createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse('https://6767d3e0c1de2e6421c85934.mockapi.io/todo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            ElevatedButton(
              onPressed: () {
                createPost(titleController.text, bodyController.text)
                    .then((post) {
                  Navigator.pop(context);
                });
              },
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdatePostPage extends StatelessWidget {
  final Post post;
  final TextEditingController titleController;

  UpdatePostPage({
    required this.post,
  }) : titleController = TextEditingController(text: post.title);

  Future<Post> updatePost(String id, String title) async {
    final response = await http.put(
      Uri.parse('https://6767d3e0c1de2e6421c85934.mockapi.io/todo/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,

      }),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            ElevatedButton(
              onPressed: () {
                updatePost(post.id, titleController.text).then((post) {
                  Navigator.pop(context);
                });
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

class Post {
  final String id;
  final String title;

  Post({required this.id, required this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
    );
  }
}