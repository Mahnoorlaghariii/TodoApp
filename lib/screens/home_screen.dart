import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/task_provider.dart';
import 'package:todolist/screens/add_Task.dart';
import 'package:todolist/widgets/quoteCard.dart';
import 'package:todolist/widgets/tasks_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> filters = ['All', 'Completed', 'Pending'];
  bool showQuote = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: filters.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    String selectedFilter = filters[_tabController.index];
    final tasks = taskProvider.filteredTasks(selectedFilter);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 41, 41),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 41, 41),
        foregroundColor: Colors.white,
        title: const Text("To-Do App"),
        bottom: 
        PreferredSize(
            preferredSize: Size.fromHeight(48),
          child: Center(
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              indicator: BoxDecoration(
                color: Colors.white.withOpacity(0.1), // Indicator color
                borderRadius: BorderRadius.circular(20),
              ),
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.6),
              tabs: filters.map((filter) {
                Widget textWidget = Text(filter);
            
                if (filter == 'All') {
                  final hasIncompleteTasks = taskProvider.tasks.any((task) => !task.isCompleted);
                  textWidget = Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Text(filter),
                      if (hasIncompleteTasks)
                        Positioned(
                          right: -6,
                          top: -10,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  );
                }
            
                return Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8), 
                    child: textWidget,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1E1E1E),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color.fromARGB(255, 66, 193, 189)),
              child: const Text(
                "Welcome!",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.white),
              title: const Text("Done all tasks", style: TextStyle(color: Colors.white)),
              onTap: () {
                taskProvider.markAllDone();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.white),
              title: const Text("Delete all tasks", style: TextStyle(color: Colors.white)),
              onTap: () {
                taskProvider.deleteAll();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text("About", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (showQuote)
            QuoteCard(onClose: () {
              setState(() {
                showQuote = false;
              });
            }),
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    child: Text(
                      "You have no tasks!",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TasksCard(
                        task: task,
                        onToggle: () => taskProvider.toggleTaskStatus(task),
                        onDelete: () => taskProvider.deleteTask(task),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 160, 159, 159),
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTask()),
          );
        },
      ),
    );
  }
}
