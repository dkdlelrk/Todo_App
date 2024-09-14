import 'package:flutter/material.dart';

class InstagramHomePage extends StatefulWidget {
  const InstagramHomePage({super.key});

  @override
  State<InstagramHomePage> createState() => _InstagramHomePageState();
}

class _InstagramHomePageState extends State<InstagramHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: const Icon(Icons.camera_alt, color: Colors.black),
        title: const Text(
          'Instagram',
          style: TextStyle(color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.live_tv, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          // Stories Section
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/avatar.png'),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'User',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          // Post Section
          for (int i = 0; i < 5; i++) _buildPost(),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '',
          ),
        ],
      ),
    );
  }

  // Single Post Widget
  Widget _buildPost() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Post Header (User Info)
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
          title: const Text('User Name'),
          subtitle: const Text('Location'),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ),

        // Post Image
        Container(
          height: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/post_image.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Post Actions (Like, Comment, Share)
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.comment_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {},
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {},
            ),
          ],
        ),

        // Post Likes
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Liked by user123 and 42 others',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // Post Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'user_name ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                TextSpan(
                  text: 'This is the caption of the post',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
