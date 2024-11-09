import 'package:chat_iq/index.dart';

void main() {
  runApp(ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatBot App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatBotHomeScreen(),
    );
  }
}

class ChatBotHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBot'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile/settings
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Text(
              'Hi, User!',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'How can I assist you today?',
              style: TextStyle(fontSize: 18.sp, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),

            // Suggested Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessagesScreen()));
                  },
                  child: Text('Start a Chat'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Go to recent chats
                  },
                  child: Text('Recent Chats'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Open FAQs
                  },
                  child: Text('FAQs'),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Chat Interface Preview
            Text(
              'Recent Chats',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with actual chat count
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(child: Icon(Icons.chat_bubble)),
                    title: Text('Chat with Bot $index'),
                    subtitle: Text('Last message preview...'),
                    trailing: Text('2:30 PM'),
                    onTap: () {
                      // Navigate to chat screen
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button to Start New Chat
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Start a new chat
        },
        child: Icon(Icons.add),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle navigation on tap
        },
      ),
    );
  }
}
