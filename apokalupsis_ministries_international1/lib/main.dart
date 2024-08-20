import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const Color neonGreen = Color.fromARGB(255, 3, 199, 78);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MainScreen(
        onToggleTheme: () {
          setState(() {
            _isDarkMode = !_isDarkMode;
          });
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const MainScreen({super.key, required this.onToggleTheme});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePage(),
      const VideosPage(),
      const DevotionalsPage(),
      EventsPage(onToggleTheme: widget.onToggleTheme),
    ];

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/resized_banner_logo.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 16.0,
              top: 16.0,
              child: Container(
                color: Colors.lightBlue.withOpacity(0.8),
                padding: const EdgeInsets.all(4.0),
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onSelected: (String result) {},
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Contact Us',
                      child: Text('Contact Us'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Giving',
                      child: Text('Giving'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Marriage',
                      child: Text('Marriage'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Upcoming Events',
                      child: Text('Upcoming Events'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Devotionals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Tribe',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped,
      ),
    );
  }
}

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sermons/Video Page"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Latest"),
              Tab(text: "Saved videos"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            VideoSection(title: "Latest", videos: List.generate(10, (index) => "Video $index")),
            VideoSection(title: "Saved videos", videos: List.generate(5, (index) => "Saved Video $index")),
          ],
        ),
      ),
    );
  }
}

class VideoSection extends StatelessWidget {
  final String title;
  final List<String> videos;

  const VideoSection({super.key, required this.title, required this.videos});

  @override
  Widget build(BuildContext context) {
    const double thumbnailHeight = 150.0;
    const double thumbnailWidth = 300.0;

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: videos.length - 1,
            itemBuilder: (context, index) {
              return Container(
                height: thumbnailHeight,
                width: thumbnailWidth,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                color: Colors.grey,
                child: Center(
                  child: Text(
                    videos[index + 1],
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Section(
            title: 'Videos',
            items: List.generate(10, (index) => 'Video $index'),
            thumbnailWidth: 300,
          ),
          Section(
            title: 'Devotionals',
            items: List.generate(10, (index) => 'Devotional $index'),
            thumbnailWidth: 300,
          ),
          Section(
            title: 'Upcoming Events',
            items: List.generate(10, (index) => 'Event $index'),
            thumbnailWidth: 300,
          ),
        ],
      ),
    );
  }
}

class DevotionalsPage extends StatelessWidget {
  const DevotionalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Devotionals"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Latest"),
              Tab(text: "Favorites"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DevotionalSection(sectionTitle: "Latest"),
            DevotionalSection(sectionTitle: "Favorites"),
          ],
        ),
      ),
    );
  }
}

class DevotionalSection extends StatelessWidget {
  final String sectionTitle;

  const DevotionalSection({super.key, required this.sectionTitle});

  @override
  Widget build(BuildContext context) {
    const double thumbnailHeight = 150.0;
    const double thumbnailWidth = 150.0;

    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < 3; i++)
            Row(
              children: [
                Container(
                  height: thumbnailHeight,
                  width: thumbnailWidth,
                  margin: const EdgeInsets.all(8.0),
                  color: neonGreen,
                  child: const Center(
                    child: Icon(Icons.picture_as_pdf, size: 50, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Devotional Title $i',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Description for Devotional $i goes here. a short summary or introductory text.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class EventsPage extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const EventsPage({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Apokalupsis Tribe',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: onToggleTheme,
          ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final List<String> items;
  final double thumbnailWidth;

  const Section({
    super.key,
    required this.title,
    required this.items,
    required this.thumbnailWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: thumbnailWidth,
                color: neonGreen,
                child: Center(
                  child: Text(
                    items[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
