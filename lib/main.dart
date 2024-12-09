import 'package:flutter/material.dart';
import 'dart:convert';

//import 'dart:math';
//import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LogInPage(),
    );
  }
}

// Global accounts for demonstration purposes
List<Map<String, String>> _accounts = [
  {'email': 'josev@dusty.tamiu.edu', 'password': 'A00000000'},
  {'email': 'mustafaallail@dusty.tamiu.edu', 'password': 'A11111111'},
  {'email': 'johndoe@dusty.tamiu.edu', 'password': 'A22222222'},
  {'email': 'christinab@dusty.tamiu.edu', 'password': 'A33333333'},
  {'email': 'carlosv@dusty.tamiu.edu', 'password': 'A44444444'},
];

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    final Map<String, String> user = _accounts.firstWhere(
      (account) => account['email'] == email && account['password'] == password,
      orElse: () => {'email': 'invalid', 'password': 'invalid'},
    );

    if (user['email'] != 'invalid') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentInfoScreen(
            email: user['email']!,
            studentID: user['password']!,
            studentId: '',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Maroon header
          Container(
            height: 91,
            color: const Color(0xFF61162D),
            child: const Center(
              child: Text(
                'TEXAS A&M INTERNATIONAL UNIVERSITY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Gold bar below the header
          Container(
            height: 32,
            color: const Color(0xFFB5A36A),
          ),
          // Login form with SingleChildScrollView
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20), // Adjust spacing at the top
                  const Text(
                    'LOG IN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF61162D),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB5A36A),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF61162D),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Adjust spacing at the bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Check if the email already exists
    if (_accounts.any((account) => account['email'] == email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email already exists')),
      );
    } else {
      // Add new user account
      _accounts.add({'email': email, 'password': password});

      // Navigate back to LogInPage
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: const Color(0xFF61162D),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'CREATE ACCOUNT',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF61162D),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB5A36A),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentInfoScreen extends StatefulWidget {
  final String email;
  final String studentID;

  const StudentInfoScreen({
    Key? key,
    required this.email,
    required this.studentID,
    required String studentId,
  }) : super(key: key);

  @override
  _StudentInfoScreenState createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends State<StudentInfoScreen> {
  late String _studentID;

  // Selected values
  String _selectedProgram = '';
  String _selectedMajor = '';

// Degree programs and corresponding majors
  final Map<String, List<String>> _degreePrograms = {
    "A.R. Sanchez, Jr. School of Business": [
      "Accounting (BBA)",
      "Business Administration (BBA)",
      "Finance (BBA)",
      "International Economics (BBA)",
      "Management (BAAS)",
      "Management (BBA)",
      "Management Information Systems and Data Analytics (BBA)",
      "Marketing (BBA)",
      "Transportation & International Logistics (BAAS)",
      "Transportation and International Logistics (BBA)",
    ],
    "College of Arts and Sciences": [
      "Biology (BA)",
      "Biology (BS)",
      "Chemistry (BS)",
      "Science with Grades 7-12 Certification (BS)",
      "Computer Engineering (BS)",
      "Petroleum Engineering (BS)",
      "Systems Engineering (BS)",
      "Art (BA)",
      "Art with All Level Certification (BA)",
      "Music in Performance (BM)",
      "Music with All Level Certification (BM)",
      "Communication and Spanish (BA)",
      "English (BA)",
      "English with Grade 7-12 Certification (BA)",
      "History (BA)",
      "History and Political Science (BA)",
      "History with Grades 7-12 Certification (BA)",
      "Spanish (BA)",
      "Spanish with All Level Certification (BA)",
      "Mathematics (BA)",
      "Mathematics with Grades 7-12 Certification (BA)",
      "Mathematics (BS)",
      "Communication and Spanish (BA)",
      "Communication (BA)",
      "Communication - Media Production (BA)",
      "Communication with Concentration in Digital & Strategic Communication (Texas A&M-RELLIS Campus; BA/Comm)",
      "Psychology (BA)",
      "Applied Arts and Sciences (BAAS)",
      "Applied Arts and Sciences Criminal Justice Concentration (BAAS)",
      "Criminal Justice and Political Science (BA)",
      "History and Political Science (BA)",
      "Political Science (BA)",
      "Sociology (BA)",
      "Criminal Justice (BSCJ)",
    ],
    "College of Education": [
      "Elementary Education and Teaching with a Bilingual Emphasis (BS)",
      "Elementary Education and Teaching with an Early Learning Emphasis (BS)",
      "Elementary Education and Teaching with a Special Education Emphasis (BS)",
    ],
    "College of Nursing and Health Sciences": [
      "Communication Disorders (BS)",
      "Nursing (BSN)",
      "Kinesiology with Concentration in Exercise Science (BS)",
      "Kinesiology with Concentration in Health & Fitness (BS)",
      "Public Health",
      "Kinesiology with a concentration in Physical Education with EC-12 Certification (BS)",
      "Kinesiology with a Concentration in Pre-Physical/Occupational Therapy (BS)",
    ],
    "University College": [
      "Multidisciplinary Studies (BA)",
    ],
  };

  @override
  void initState() {
    super.initState();
    _studentID = widget.studentID; // Initialize the student ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED), // Light gray background
      appBar: AppBar(
        backgroundColor: const Color(0xFF500000), // Maroon color
        title: const Text(
          'Texas A&M International University',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Small Maroon Line
            Container(
              height: 5,
              color: const Color(0xFF500000), // Maroon color
            ),
            const SizedBox(height: 20),

            // Student Info Section
            _buildStudentInfoSection(),

            const SizedBox(height: 20), // Add some space between the sections

            // Scheduler Section (Fall & Spring buttons)
            _buildSchedulerSection(context),

            const SizedBox(height: 20), // Space between sections

            // Organizations Section
            _buildOrganizationsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF909191), // Light gray color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Student Info',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Email: ${widget.email}',
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          Text(
            'Student ID: $_studentID',
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(height: 20),

          // Degree Program Dropdown
          const Text(
            'Select Degree Program:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedProgram.isNotEmpty ? _selectedProgram : null,
            items: _degreePrograms.keys.map((program) {
              return DropdownMenuItem<String>(
                value: program,
                child: Text(program),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedProgram = value!;
                _selectedMajor = ''; // Reset major when program changes
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            ),
            hint: const Text(
              'Choose a program',
              style: TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 20),

          // Major Dropdown
          const Text(
            'Select Major:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedMajor.isNotEmpty ? _selectedMajor : null,
            items: (_selectedProgram.isNotEmpty
                    ? _degreePrograms[_selectedProgram]
                    : [])
                ?.map((major) {
              return DropdownMenuItem<String>(
                value: major,
                child: Text(major),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedMajor = value!;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            ),
            hint: const Text(
              'Choose a major',
              style: TextStyle(fontSize: 14),
            ),
          ),

          const SizedBox(
              height: 20), // Add space before the Edit Classes button

          // Edit Classes Button
          // Inside the StudentInfoScreen widget
          GestureDetector(
            onTap: () {
              if (_selectedMajor.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClassInputScreen(
                      selectedMajor: _selectedMajor, // Pass selected major here
                      major: _selectedMajor, // Pass selected major here as well
                    ),
                  ),
                );
              }
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
              decoration: BoxDecoration(
                color: const Color(0xFF500000), // Maroon color
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Edit Classes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSchedulerSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF909191), // Light gray color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Scheduler',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // This will space out the buttons
            children: [
              GestureDetector(
                onTap: () {
                  if (_selectedMajor.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FallScreen(
                          major: _selectedMajor,
                          completedCourses: [],
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 40.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF500000),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Fall',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_selectedMajor.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpringScreen(
                          major: _selectedMajor,
                          completedCourses: [],
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 40.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF500000),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Spring',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizationsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF909191), // Light gray color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Organizations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Recommended Box
              GestureDetector(
                onTap: () {
                  // Navigate to Recommended Organizations screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecommendedOrganizationsScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 40.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF500000), // Maroon color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Recommended',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Current Box
              GestureDetector(
                onTap: () {
                  // Navigate to Current Organizations screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CurrentOrganizationsScreen(
                        currentOrganizations: [],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 40.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF500000), // Maroon color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Current',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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

class RecommendedOrganizationsScreen extends StatefulWidget {
  @override
  _RecommendedOrganizationsScreenState createState() =>
      _RecommendedOrganizationsScreenState();
}

class _RecommendedOrganizationsScreenState
    extends State<RecommendedOrganizationsScreen> {
  Color maroonColor = Color(0xFF61162D); // Maroon color

  // List of recommended organizations
  List<String> recommendedOrganizations = [
    "Computer Science and Engineering Association",
    "Society of Hispanic Professional Engineers (SHPE)",
    "TAMIU DustyMOTOR - Society of Automotive Engineers (SAE) International",
    "Society of Petroleum Engineers (TAMIU-SPE)",
    "Society of Women Engineers (SWE)",
    "Student Orientation Leadership and Engagement (SOLE)",
    "I.C.A.R.U.S.",
    "Other" // This can be used for user input
  ];

  // List of current organizations (initially empty)
  List<String> currentOrganizations = [];

  // Controller for user input
  TextEditingController _otherOrganizationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentOrganizations();
  }

  // Load saved current organizations from SharedPreferences
  Future<void> _loadCurrentOrganizations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedOrganizations = prefs.getString('currentOrganizations');
    if (savedOrganizations != null) {
      setState(() {
        currentOrganizations =
            List<String>.from(json.decode(savedOrganizations));
      });
    }
  }

  // Save current organizations to SharedPreferences
  Future<void> _saveCurrentOrganizations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String organizationsJson = json.encode(currentOrganizations);
    await prefs.setString('currentOrganizations', organizationsJson);
  }

  // Move organization to current organizations
  void _moveToCurrentOrganizations(String organization) {
    setState(() {
      recommendedOrganizations
          .remove(organization); // Remove from recommended list
      currentOrganizations
          .add(organization); // Add to current organizations list
      _saveCurrentOrganizations(); // Save the updated list
    });
  }

  // Add custom organization from user input
  void _addCustomOrganization() {
    String newOrganization = _otherOrganizationController.text.trim();
    if (newOrganization.isNotEmpty) {
      setState(() {
        currentOrganizations.add(newOrganization);
        recommendedOrganizations.remove("Other");
        _saveCurrentOrganizations(); // Save the updated list
        _otherOrganizationController.clear(); // Clear the input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommended Organizations"),
        backgroundColor: maroonColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recommended Organizations:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Display the recommended organizations list
            Expanded(
              child: ListView.builder(
                itemCount: recommendedOrganizations.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      title: Text(recommendedOrganizations[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.add, color: Colors.green),
                        onPressed: () => _moveToCurrentOrganizations(
                            recommendedOrganizations[
                                index]), // Move organization
                      ),
                    ),
                  );
                },
              ),
            ),
            // Add TextField for "Other" user input
            if (recommendedOrganizations.contains("Other"))
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter a custom organization:',
                      style: TextStyle(fontSize: 14),
                    ),
                    TextField(
                      controller: _otherOrganizationController,
                      decoration: InputDecoration(
                        labelText: 'Organization Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: _addCustomOrganization,
                      child: const Text('Add Organization'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CurrentOrganizationsScreen extends StatefulWidget {
  final List<String> currentOrganizations; // Declare the parameter

  // Constructor to accept currentOrganizations as a named parameter
  CurrentOrganizationsScreen({Key? key, required this.currentOrganizations})
      : super(key: key);

  @override
  _CurrentOrganizationsScreenState createState() =>
      _CurrentOrganizationsScreenState();
}

class _CurrentOrganizationsScreenState
    extends State<CurrentOrganizationsScreen> {
  Color maroonColor = Color(0xFF61162D); // Maroon color

  List<String> currentOrganizations = [];

  @override
  void initState() {
    super.initState();
    _loadCurrentOrganizations();
  }

  // Load saved current organizations from SharedPreferences
  Future<void> _loadCurrentOrganizations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedOrganizations = prefs.getString('currentOrganizations');
    if (savedOrganizations != null) {
      setState(() {
        currentOrganizations =
            List<String>.from(json.decode(savedOrganizations));
      });
    }
  }

  // Save current organizations to SharedPreferences
  Future<void> _saveCurrentOrganizations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String organizationsJson = json.encode(currentOrganizations);
    await prefs.setString('currentOrganizations', organizationsJson);
  }

  // Remove organization from current list
  void _removeFromCurrentOrganizations(int index) {
    setState(() {
      currentOrganizations.removeAt(index);
      _saveCurrentOrganizations(); // Save the updated list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Organizations"),
        backgroundColor: maroonColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Current Organizations:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Display current organizations
            if (currentOrganizations.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: currentOrganizations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: Text(currentOrganizations[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              _removeFromCurrentOrganizations(index),
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              const Center(child: Text("No current organizations added.")),
          ],
        ),
      ),
    );
  }
}

// New ClassInputScreen (For the "Class Input" feature)

class ClassInputScreen extends StatefulWidget {
  final String selectedMajor;

  ClassInputScreen({required this.selectedMajor, required String major});

  @override
  _ClassInputScreenState createState() => _ClassInputScreenState();
}

class _ClassInputScreenState extends State<ClassInputScreen> {
  // Courses for different majors
  final Map<String, List<Map<String, String>>> _majorsCourses = {
    'Accounting (BBA)': [
      {'course': 'English 1301 English Composition I', 'credit': '3'},
      {'course': 'History 1301 The United States to 1877', 'credit': '3'},
      {'course': 'Mathematics 1324 Business Mathematics I', 'credit': '3'},
      {'course': 'University 1201 Learn a Global Context I', 'credit': '2'},
      {
        'course': 'Business Administration 1301 Business Principles',
        'credit': '3'
      },
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'Life and Physical Science Laboratory', 'credit': '1'},
      {'course': 'English 1302 English Composition II', 'credit': '3'},
      {'course': 'History 1302 The United States Since 1877', 'credit': '3'},
      {'course': 'Mathematics 1325 Business Mathematics II', 'credit': '3'},
      {'course': 'University 1302 Signature Course', 'credit': '3'},
      {'course': 'Life and Physical Science (Course 2)', 'credit': '3'},
      {
        'course': 'Accounting 2301 Introduction to Financial Accounting',
        'credit': '3'
      },
      {'course': 'Decision Sciences 2310 Business Statistics I', 'credit': '3'},
      {'course': 'Economics 2301 Principles of Macroeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2305 American National Government',
        'credit': '3'
      },
      {
        'course': 'Accounting 2302 Introduction to Managerial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2302 Principles of Microeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2306 American State Government',
        'credit': '3'
      },
      {'course': 'General Elective 1', 'credit': '3'},
      {'course': 'Accounting 3310 Intermediate Accounting I', 'credit': '3'},
      {
        'course': 'Accounting 3370 Introduction to Accounting Systems',
        'credit': '3'
      },
      {
        'course':
            'Business Administration 3301 Professional Written Communication',
        'credit': '3'
      },
      {'course': 'Finance 3310 Introduction to Finance', 'credit': '3'},
      {
        'course':
            'Management Information Systems 3310 Management Information Systems',
        'credit': '3'
      },
      {'course': 'Accounting 3320 Intermediate Accounting II', 'credit': '3'},
      {
        'course': 'Accounting 3340 Advanced Managerial Accounting',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3310 Legal Environment of Business',
        'credit': '3'
      },
      {'course': 'Management 3310 Principles of Management', 'credit': '3'},
      {'course': 'Marketing 3310 Principles of Marketing', 'credit': '3'},
      {'course': 'Accounting 3330 Intermediate Accounting III', 'credit': '3'},
      {'course': 'Accounting 3350 Federal Taxation', 'credit': '3'},
      {
        'course': 'Business Administration 3320 International Business',
        'credit': '3'
      },
      {'course': 'Economics 3320 Managerial Economics', 'credit': '3'},
      {'course': 'Advanced Business Elective', 'credit': '3'},
      {'course': 'Accounting 4370 Auditing and Systems', 'credit': '3'},
      {
        'course': 'Business Administration 4390 Business Strategy',
        'credit': '3'
      },
      {
        'course':
            'Production and Operations Management 3310 Production and Operations Management',
        'credit': '3'
      },
      {'course': 'Advanced Accounting Elective 2', 'credit': '3'},
    ],
    // Add other majors and their courses here, for example:
    'Accounting (BAAS)': [
      {'course': 'English 1301 English Composition I', 'credit': '3'},
      {'course': 'History 1301 The United States to 1877', 'credit': '3'},
      {'course': 'Mathematics 1324 Business Mathematics I', 'credit': '3'},
      {'course': 'University 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'Life and Physical Science Laboratory', 'credit': '1'},
      {'course': 'English 1302 English Composition II', 'credit': '3'},
      {'course': 'History 1302 The United States Since 1877', 'credit': '3'},
      {'course': 'Mathematics 1325 Business Mathematics II', 'credit': '3'},
      {'course': 'University 1302 Signature Course', 'credit': '3'},
      {'course': 'Life and Physical Science 1', 'credit': '3'},
      {
        'course': 'Accounting 2301 Introduction to Financial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2301 Principles of Macroeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2305 American National Government',
        'credit': '3'
      },
      {'course': 'Language, Philosophy and Culture', 'credit': '3'},
      {
        'course': 'Vocational Technical Field (Business Related) 1',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (Business Related) 2',
        'credit': '3'
      },
      {
        'course': 'Accounting 2302 Introduction to Managerial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2302 Principles of Microeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2306 American State Government',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (Business Related) 3',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (Business Related) 4',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (Business Related) 5',
        'credit': '3'
      },
      {'course': 'Business Administration 3301 ', 'credit': '3'},
      {'course': 'Finance 3310 Introduction to Finance', 'credit': '3'},
      {'course': 'Management 3310 Principles of Management', 'credit': '3'},
      {
        'course': 'Vocational Technical Field (Business Related) 6',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (Business Related) 7',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3310 Legal Environment of Business',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3320 International Business',
        'credit': '3'
      },
      {'course': 'Management Information Systems 3310 ', 'credit': '3'},
      {'course': 'Marketing 3310 Principles of Marketing', 'credit': '3'},
      {'course': 'Economics 3320 Managerial Economics', 'credit': '3'},
      {
        'course': 'Transportation 3310 Principles of Transportation',
        'credit': '3'
      },
      {'course': 'Advanced Business Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {
        'course': 'Business Administration 4390 Business Strategy',
        'credit': '3'
      },
      {'course': 'Advanced Business Elective 2', 'credit': '3'},
      {'course': 'Advanced Business Elective 3', 'credit': '3'},
      {'course': 'Advanced General Elective 2', 'credit': '3'},
    ],
    'Business Administration (BBA)': [
      {'course': 'English 1301 English Composition I', 'credit': '3'},
      {'course': 'History 1301 The United States to 1877', 'credit': '3'},
      {'course': 'Mathematics 1324 Business Mathematics I', 'credit': '3'},
      {'course': 'University 1201 Learn a Global Context I', 'credit': '2'},
      {
        'course': 'Business Administration 1301 Business Principles',
        'credit': '3'
      },
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'Life and Physical Science Laboratory', 'credit': '1'},
      {'course': 'English 1302 English Composition II', 'credit': '3'},
      {'course': 'History 1302 The United States Since 1877', 'credit': '3'},
      {'course': 'Mathematics 1325 Business Mathematics II', 'credit': '3'},
      {'course': 'University 1302 Signature Course', 'credit': '3'},
      {'course': 'Life and Physical Science*', 'credit': '3'},
      {
        'course': 'Accounting 2301 Introduction to Financial Accounting',
        'credit': '3'
      },
      {'course': 'Data Science 2310 Business Statistics I', 'credit': '3'},
      {'course': 'Economics 2301 Principles of Macroeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2305 American National Government',
        'credit': '3'
      },
      {'course': 'Language, Philosophy and Culture', 'credit': '3'},
      {
        'course': 'Accounting 2302 Introduction to Managerial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2302 Principles of Microeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2306 American State Government',
        'credit': '3'
      },
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'General Elective 1', 'credit': '3'},
      {
        'course':
            'Business Administration 3301 Professional Written Communication',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3320 International Business',
        'credit': '3'
      },
      {'course': 'Economics 3320 Managerial Economics', 'credit': '3'},
      {'course': 'Finance 3310 Introduction to Finance', 'credit': '3'},
      {'course': 'Management 3310 Principles of Management', 'credit': '3'},
      {
        'course': 'Business Administration 3310 Legal Environment of Business',
        'credit': '3'
      },
      {
        'course':
            'Management Information Systems 3310 Management Information Systems',
        'credit': '3'
      },
      {'course': 'Marketing 3310 Principles of Marketing', 'credit': '3'},
      {'course': 'Accounting Advanced Elective', 'credit': '3'},
      {'course': 'Finance Advanced Elective', 'credit': '3'},
      {
        'course':
            'Production and Operations Management 3310 Production & Operations Management',
        'credit': '3'
      },
      {'course': 'Accounting Advanced Elective 2', 'credit': '3'},
      {'course': 'Finance Advanced Elective 2', 'credit': '3'},
      {'course': 'Management Advanced Elective', 'credit': '3'},
      {'course': 'Marketing/Transportation Advanced Elective', 'credit': '3'},
      {
        'course': 'Business Administration 4390 Business Strategy',
        'credit': '3'
      },
      {'course': 'Economics Advanced Elective', 'credit': '3'},
      {'course': 'Management Advanced Elective 2', 'credit': '3'},
      {'course': 'Marketing/Transportation Advanced Elective 2', 'credit': '3'},
    ],
    'Finance (BBA)': [
      {'course': 'English 1301 English Composition I', 'credit': '3'},
      {'course': 'History 1301 The United States to 1877', 'credit': '3'},
      {'course': 'Mathematics 1324 Business Mathematics I', 'credit': '3'},
      {'course': 'University 1201 Learn a Global Context I', 'credit': '2'},
      {
        'course': 'Business Administration 1301 Business Principles',
        'credit': '3'
      },
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'Life and Physical Science Laboratory', 'credit': '1'},
      {'course': 'English 1302 English Composition II', 'credit': '3'},
      {'course': 'History 1302 The United States Since 1877', 'credit': '3'},
      {'course': 'Mathematics 1325 Business Mathematics II', 'credit': '3'},
      {'course': 'University 1302 Signature Course', 'credit': '3'},
      {'course': 'Life and Physical Science*', 'credit': '3'},
      {
        'course': 'Accounting 2301 Introduction to Financial Accounting',
        'credit': '3'
      },
      {'course': 'Data Science 2310 Business Statistics I', 'credit': '3'},
      {'course': 'Economics 2301 Principles of Macroeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2305 American National Government',
        'credit': '3'
      },
      {'course': 'Language, Philosophy and Culture', 'credit': '3'},
      {
        'course': 'Accounting 2302 Introduction to Managerial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2302 Principles of Microeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2306 American State Government',
        'credit': '3'
      },
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'General Elective 1', 'credit': '3'},
      {'course': 'Accounting 3310 Intermediate Accounting I', 'credit': '3'},
      {
        'course':
            'Business Administration 3301 Professional Written Communication',
        'credit': '3'
      },
      {'course': 'Finance 3310 Introduction to Finance', 'credit': '3'},
      {'course': 'Management 3310 Principles of Management', 'credit': '3'},
      {
        'course':
            'Management Information Systems 3310 Management Information Systems',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3310 Legal Environment of Business',
        'credit': '3'
      },
      {'course': 'Economics 3310 Money and Banking', 'credit': '3'},
      {
        'course': 'Finance 3320 Financial Institutions Management & Regulation',
        'credit': '3'
      },
      {'course': 'Finance 3360 Managerial Finance', 'credit': '3'},
      {'course': 'Marketing 3310 Principles of Marketing', 'credit': '3'},
      {
        'course': 'Business Administration 3320 International Business',
        'credit': '3'
      },
      {'course': 'Economics 3320 Managerial Economics', 'credit': '3'},
      {'course': 'Finance 3330 Investments', 'credit': '3'},
      {'course': 'Finance 4380 International Finance', 'credit': '3'},
      {'course': 'Finance Restricted Elective 2', 'credit': '3'},
      {
        'course': 'Business Administration 4390 Business Strategy',
        'credit': '3'
      },
      {
        'course':
            'Production and Operations Management 3310 Production & Operations Management',
        'credit': '3'
      },
      {'course': 'Finance Restricted Elective 2', 'credit': '3'},
      {'course': 'Finance Restricted Elective 2', 'credit': '3'},
    ],
    'International Economics (BBA)': [
      {'course': 'English 1301 English Composition I', 'credit': '3'},
      {'course': 'History 1301 The United States to 1877', 'credit': '3'},
      {'course': 'Mathematics 1324 Business Mathematics I', 'credit': '3'},
      {'course': 'University 1201 Learn a Global Context I', 'credit': '2'},
      {
        'course': 'Business Administration 1301 Business Principles',
        'credit': '3'
      },
      {'course': 'Life and Physical Science Laboratory', 'credit': '1'},
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'English 1302 English Composition II', 'credit': '3'},
      {'course': 'History 1302 The United States Since 1877', 'credit': '3'},
      {'course': 'Mathematics 1325 Business Mathematics II', 'credit': '3'},
      {'course': 'University 1302 Signature Course', 'credit': '3'},
      {'course': 'Life and Physical Science*', 'credit': '3'},
      {
        'course': 'Accounting 2301 Introduction to Financial Accounting',
        'credit': '3'
      },
      {'course': 'Data Science 2310 Business Statistics I', 'credit': '3'},
      {'course': 'Economics 2301 Principles of Macroeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2305 American National Government',
        'credit': '3'
      },
      {'course': 'Language, Philosophy and Culture', 'credit': '3'},
      {
        'course': 'Accounting 2302 Introduction to Managerial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2302 Principles of Microeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2306 American State Government',
        'credit': '3'
      },
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'General Elective 1', 'credit': '3'},
      {
        'course':
            'Business Administration 3301 Professional Written Communication',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3320 International Business',
        'credit': '3'
      },
      {'course': 'Economics 4310 Intermediate Macroeconomics', 'credit': '3'},
      {'course': 'Economics 4340 International Economics', 'credit': '3'},
      {
        'course':
            'Management Information Systems 3310 Management Information Systems',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3310 Legal Environment of Business',
        'credit': '3'
      },
      {'course': 'Economics 3320 Managerial Economics', 'credit': '3'},
      {'course': 'Finance 3310 Introduction to Finance', 'credit': '3'},
      {'course': 'Management 3310 Principles of Management', 'credit': '3'},
      {'course': 'Marketing 3310 Principles of Marketing', 'credit': '3'},
      {'course': 'Economics 4380 Applied Econometrics', 'credit': '3'},
      {
        'course':
            'Production and Operations Management 3310 Production & Operations Management',
        'credit': '3'
      },
      {'course': 'Economics Restricted Elective 2', 'credit': '3'},
      {'course': 'Economics Restricted Elective 2', 'credit': '3'},
      {'course': 'Advanced Business Elective', 'credit': '3'},
      {
        'course': 'Business Administration 4390 Business Strategy',
        'credit': '3'
      },
      {'course': 'Economics 3310 Money and Banking', 'credit': '3'},
      {'course': 'Economics 4320 Intermediate Microeconomics', 'credit': '3'},
      {'course': 'Economics Restricted Elective 2', 'credit': '3'},
    ],
    'Management (BAAS)': [
      {'course': 'English 1301 English Composition I', 'credit': '3'},
      {'course': 'History 1301 The United States to 1877', 'credit': '3'},
      {'course': 'Mathematics 1324 Business Mathematics I', 'credit': '3'},
      {'course': 'University 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'Life and Physical Science Laboratory', 'credit': '1'},
      {'course': 'English 1302 English Composition II', 'credit': '3'},
      {'course': 'History 1302 The United States Since 1877', 'credit': '3'},
      {'course': 'Mathematics 1325 Business Mathematics II', 'credit': '3'},
      {'course': 'University 1302 Signature Course', 'credit': '3'},
      {'course': 'Life and Physical Science 1', 'credit': '3'},
      {
        'course': 'Accounting 2301 Introduction to Financial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2301 Principles of Macroeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2305 American National Government',
        'credit': '3'
      },
      {'course': 'Language, Philosophy and Culture', 'credit': '3'},
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Accounting 2302 Introduction to Managerial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2302 Principles of Microeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2306 American State Government',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course':
            'Business Administration 3301 Professional Written Communication',
        'credit': '3'
      },
      {'course': 'Management 3310 Principles of Management', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3310 Legal Environment of Business',
        'credit': '3'
      },
      {'course': 'Management 3320 Organizational Behavior', 'credit': '3'},
      {'course': 'Management 3340 Business Ethics', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Management 3370 Human Resources Management', 'credit': '3'},
      {
        'course': 'Management 4350 Business, Government & Society',
        'credit': '3'
      },
      {'course': 'Management 4380 Organizational Theory', 'credit': '3'},
      {'course': 'Advanced Business Elective', 'credit': '3'},
      {
        'course': 'Business Administration 4390 Business Strategy',
        'credit': '3'
      },
      {
        'course': 'Management 4340 Leadership Theory and Practice',
        'credit': '3'
      },
      {
        'course': 'Management 4360 Entrepreneurship & Management of Innovation',
        'credit': '3'
      },
      {'course': 'Advanced Business Elective', 'credit': '3'},
    ],
    'Management (BBA)': [
      {'course': 'English 1301 English Composition I', 'credit': '3'},
      {'course': 'History 1301 The United States to 1877', 'credit': '3'},
      {'course': 'Mathematics 1324 Business Mathematics I', 'credit': '3'},
      {'course': 'University 1201 Learn a Global Context I', 'credit': '2'},
      {
        'course': 'Business Administration 1301 Business Principles',
        'credit': '3'
      },
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'Life and Physical Science Laboratory', 'credit': '1'},
      {'course': 'English 1302 English Composition II', 'credit': '3'},
      {'course': 'History 1302 The United States Since 1877', 'credit': '3'},
      {'course': 'Mathematics 1325 Business Mathematics II', 'credit': '3'},
      {'course': 'University 1302 Signature Course', 'credit': '3'},
      {'course': 'Life and Physical Science*', 'credit': '3'},
      {
        'course': 'Accounting 2301 Introduction to Financial Accounting',
        'credit': '3'
      },
      {'course': 'Decision Science 2310 Business Statistics I', 'credit': '3'},
      {'course': 'Economics 2301 Principles of Macroeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2305 American National Government',
        'credit': '3'
      },
      {'course': 'Language, Philosophy, & Culture', 'credit': '3'},
      {
        'course': 'Accounting 2302 Introduction to Managerial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2302 Principles of Microeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2306 American State Government',
        'credit': '3'
      },
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'General Elective 1', 'credit': '3'},
      {
        'course':
            'Business Administration 3301 Professional Written Communication',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3310 Legal Environment of Business',
        'credit': '3'
      },
      {'course': 'Economics 3320 Managerial Economics', 'credit': '3'},
      {'course': 'Management 3310 Principles of Management', 'credit': '3'},
      {'course': 'Marketing 3310 Principles of Marketing', 'credit': '3'},
      {
        'course': 'Business Administration 3320 International Business',
        'credit': '3'
      },
      {'course': 'Finance 3310 Introduction to Finance', 'credit': '3'},
      {'course': 'Management 3340 Business Ethics', 'credit': '3'},
      {
        'course':
            'Management Information Systems 3310 Management Information Systems',
        'credit': '3'
      },
      {
        'course':
            'Production and Operations Management 3310 Production & Operations Mgt',
        'credit': '3'
      },
      {'course': 'Management 3320 Organizational Behavior', 'credit': '3'},
      {'course': 'Management 3370 Human Resources Management', 'credit': '3'},
      {
        'course': 'Management 4350 Business, Government & Society',
        'credit': '3'
      },
      {'course': 'Management 4380 Organizational Theory', 'credit': '3'},
      {'course': 'Advanced Business Elective', 'credit': '3'},
      {
        'course': 'Business Administration 4390 Business Strategy',
        'credit': '3'
      },
      {
        'course': 'Management 4340 Leadership Theory and Practice',
        'credit': '3'
      },
      {
        'course': 'Management 4360 Entrepreneurship & Management of Innovation',
        'credit': '3'
      },
      {'course': 'Advanced Business Elective', 'credit': '3'},
    ],
    'Management Information Systems and Data Analytics (BBA)': [
      {'course': 'English 1301 English Composition I', 'credit': '3'},
      {'course': 'History 1301 The United States to 1877', 'credit': '3'},
      {'course': 'Mathematics 1324 Business Mathematics I', 'credit': '3'},
      {'course': 'University 1201 Learn a Global Context I', 'credit': '2'},
      {
        'course': 'Business Administration 1301 Business Principles',
        'credit': '3'
      },
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'Life and Physical Science Laboratory', 'credit': '1'},
      {'course': 'English 1302 English Composition II', 'credit': '3'},
      {'course': 'History 1302 The United States Since 1877', 'credit': '3'},
      {'course': 'Mathematics 1325 Business Mathematics II', 'credit': '3'},
      {'course': 'University 1302 Signature Course', 'credit': '3'},
      {
        'course': 'Accounting 2301 Introduction to Financial Accounting',
        'credit': '3'
      },
      {'course': 'Decision Science 2310 Business Statistics I', 'credit': '3'},
      {'course': 'Economics 2301 Principles of Macroeconomics', 'credit': '3'},
      {
        'course':
            'Management Information Systems 2350 Introduction to Programming',
        'credit': '3'
      },
      {
        'course': 'Political Science 2305 American National Government',
        'credit': '3'
      },
      {'course': 'Language, Philosophy, & Culture', 'credit': '3'},
      {
        'course': 'Accounting 2302 Introduction to Managerial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2302 Principles of Microeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2306 American State Government',
        'credit': '3'
      },
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'General Elective 1', 'credit': '3'},
      {
        'course':
            'Business Administration 3301 Professional Written Communication',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3320 International Business',
        'credit': '3'
      },
      {
        'course':
            'Management Information Systems 3310 Management Information Systems',
        'credit': '3'
      },
      {
        'course':
            'Management Information Systems 3320 Information System Analysis',
        'credit': '3'
      },
      {
        'course':
            'Management Information Systems 3340 Data Communication & Networking',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3310 Legal Environment of Business',
        'credit': '3'
      },
      {'course': 'Economics 3320 Managerial Economics', 'credit': '3'},
      {
        'course':
            'Management Information Systems 3330 Database Design Implementation',
        'credit': '3'
      },
      {
        'course':
            'Management Information Systems 3360 Business Data Visualization',
        'credit': '3'
      },
      {'course': 'Finance 3310 Introduction to Finance', 'credit': '3'},
      {'course': 'Management 3310 Principles of Management', 'credit': '3'},
      {
        'course':
            'Management Information Systems 4320 Data Mining and Business Intelligence',
        'credit': '3'
      },
      {
        'course':
            'Management Information Systems 4360 Social Business Analytics',
        'credit': '3'
      },
      {'course': 'Advanced MIS Elective', 'credit': '3'},
      {
        'course': 'Business Administration 4390 Business Strategy',
        'credit': '3'
      },
      {
        'course':
            'Management Information Systems 4380 Business Decision Modeling',
        'credit': '3'
      },
      {'course': 'Marketing 3310 Principles of Marketing', 'credit': '3'},
      {
        'course':
            'Production and Operations Management 3310 Production & Operations Management',
        'credit': '3'
      },
    ],
    'Marketing (BBA)': [
      {'course': 'English 1301 English Composition I', 'credit': '3'},
      {'course': 'History 1301 The United States to 1877', 'credit': '3'},
      {'course': 'Mathematics 1324 Business Mathematics I', 'credit': '3'},
      {'course': 'University 1201 Learn a Global Context I', 'credit': '2'},
      {
        'course': 'Business Administration 1301 Business Principles',
        'credit': '3'
      },
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'Life and Physical Science Laboratory', 'credit': '1'},
      {'course': 'English 1302 English Composition II', 'credit': '3'},
      {'course': 'History 1302 The United States Since 1877', 'credit': '3'},
      {'course': 'Mathematics 1325 Business Mathematics II', 'credit': '3'},
      {'course': 'University 1302 Signature Course', 'credit': '3'},
      {
        'course': 'Accounting 2301 Introduction to Financial Accounting',
        'credit': '3'
      },
      {'course': 'Decision Science 2310 Business Statistics I', 'credit': '3'},
      {'course': 'Economics 2301 Principles of Macroeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2305 American National Government',
        'credit': '3'
      },
      {'course': 'Language, Philosophy, & Culture', 'credit': '3'},
      {
        'course': 'Accounting 2302 Introduction to Managerial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2302 Principles of Microeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2306 American State Government',
        'credit': '3'
      },
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'General Elective 1', 'credit': '3'},
      {
        'course':
            'Business Administration 3301 Professional Written Communication',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3310 Legal Environment of Business',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3320 International Business',
        'credit': '3'
      },
      {'course': 'Economics 3320 Managerial Economics', 'credit': '3'},
      {'course': 'Marketing 3310 Principles of Marketing', 'credit': '3'},
      {'course': 'Finance 3310 Introduction to Finance', 'credit': '3'},
      {'course': 'Management 3310 Principles of Management', 'credit': '3'},
      {
        'course':
            'Management Information Systems 3310 Management Information Systems',
        'credit': '3'
      },
      {
        'course': 'Marketing 3330 Advertising & Promotion Management',
        'credit': '3'
      },
      {
        'course':
            'Production and Operations Management 3310 Production & Operations Management',
        'credit': '3'
      },
      {'course': 'Marketing 3320 Buyer Behavior', 'credit': '3'},
      {'course': 'Marketing 4320 Marketing Research', 'credit': '3'},
      {
        'course':
            'Transportation and Logistics 3340 Business Logistics Management',
        'credit': '3'
      },
      {'course': 'Advanced Business Elective', 'credit': '3'},
      {'course': 'Advanced Business Elective', 'credit': '3'},
      {
        'course': 'Business Administration 4390 Business Strategy',
        'credit': '3'
      },
      {'course': 'Marketing 4310 International Marketing', 'credit': '3'},
      {'course': 'Marketing 4330 Marketing Management', 'credit': '3'},
      {'course': 'Advanced Business Elective', 'credit': '3'},
    ],
    'Transportation & International Logistics (BAAS)': [
      {'course': 'English 1301 English Composition I', 'credit': '3'},
      {'course': 'History 1301 The United States to 1877', 'credit': '3'},
      {'course': 'Mathematics 1324 Business Mathematics I', 'credit': '3'},
      {'course': 'University 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'Life and Physical Science Laboratory', 'credit': '1'},
      {'course': 'English 1302 English Composition II', 'credit': '3'},
      {'course': 'History 1302 The United States Since 1877', 'credit': '3'},
      {'course': 'Mathematics 1325 Business Mathematics II', 'credit': '3'},
      {'course': 'University 1302 Signature Course', 'credit': '3'},
      {
        'course': 'Accounting 2301 Introduction to Financial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2301 Principles of Macroeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2305 American National Government',
        'credit': '3'
      },
      {'course': 'Language, Philosophy, & Culture', 'credit': '3'},
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Accounting 2302 Introduction to Managerial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2302 Principles of Microeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2306 American State Government',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course':
            'Business Administration 3301 Professional Written Communication',
        'credit': '3'
      },
      {'course': 'Marketing 3310 Principles of Marketing', 'credit': '3'},
      {
        'course':
            'Transportation & International Logistics 3310 Principles of Transportation',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Vocational Technical Field (business related)',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3310 Legal Environment of Business',
        'credit': '3'
      },
      {
        'course':
            'Transportation & International Logistics 3350 Global Business Logistics',
        'credit': '3'
      },
      {
        'course':
            'Transportation & International Logistics 3360 Supply Chain Security & Compliance',
        'credit': '3'
      },
      {'course': 'Advanced General Elective', 'credit': '3'},
      {
        'course': 'Business Administration 3320 International Business',
        'credit': '3'
      },
      {
        'course':
            'Transportation & International Logistics 3311 Export/Import Operations & Practices',
        'credit': '3'
      },
      {
        'course':
            'Transportation & International Logistics 3340 Business Logistics Management',
        'credit': '3'
      },
      {'course': 'Advanced General Elective', 'credit': '3'},
      {
        'course':
            'Business Administration 3315 Introduction to International Commercial Law',
        'credit': '3'
      },
      {
        'course': 'Business Administration 4390 Business Strategy',
        'credit': '3'
      },
      {'course': 'Advanced Business Elective', 'credit': '3'},
      {'course': 'Advanced Business Elective', 'credit': '3'},
    ],
    'Transportation and International Logistics (BBA)': [
      {'course': 'English 1301 English Composition I', 'credit': '3'},
      {'course': 'History 1301 The United States to 1877', 'credit': '3'},
      {'course': 'Mathematics 1324 Business Mathematics I', 'credit': '3'},
      {'course': 'University 1201 Learn a Global Context I', 'credit': '2'},
      {
        'course': 'Business Administration 1301 Business Principles',
        'credit': '3'
      },
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'Life and Physical Science Laboratory', 'credit': '1'},
      {'course': 'English 1302 English Composition II', 'credit': '3'},
      {'course': 'History 1302 The United States Since 1877', 'credit': '3'},
      {'course': 'Mathematics 1325 Business Mathematics II', 'credit': '3'},
      {'course': 'University 1302 Signature Course', 'credit': '3'},
      {'course': 'Life and Physical Science', 'credit': '3'},
      {
        'course': 'Accounting 2301 Introduction to Financial Accounting',
        'credit': '3'
      },
      {'course': 'Data Science 2310 Business Statistics I', 'credit': '3'},
      {'course': 'Economics 2301 Principles of Macroeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2305 American National Government',
        'credit': '3'
      },
      {'course': 'Language, Philosophy, & Culture', 'credit': '3'},
      {
        'course': 'Accounting 2302 Introduction to Managerial Accounting',
        'credit': '3'
      },
      {'course': 'Economics 2302 Principles of Microeconomics', 'credit': '3'},
      {
        'course': 'Political Science 2306 American State Government',
        'credit': '3'
      },
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'General Elective 1', 'credit': '3'},
      {
        'course':
            'Business Administration 3301 Professional Written Communication',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3310 Legal Environment of Business',
        'credit': '3'
      },
      {
        'course': 'Business Administration 3320 International Business',
        'credit': '3'
      },
      {
        'course':
            'Transportation & International Logistics 3310 Principles of Transportation',
        'credit': '3'
      },
      {'course': 'Marketing 3310 Principles of Marketing', 'credit': '3'},
      {'course': 'Finance 3310 Introduction to Finance', 'credit': '3'},
      {'course': 'Management 3310 Principles of Management', 'credit': '3'},
      {'course': 'Management Information Systems 3310', 'credit': '3'},
      {
        'course':
            'Business Administration 3315 Introduction to International Commercial Law',
        'credit': '3'
      },
      {
        'course':
            'Transportation & International Logistics 3350 Global Business Logistics',
        'credit': '3'
      },
      {'course': 'Economics 3320 Managerial Economics', 'credit': '3'},
      {
        'course':
            'Transportation & International Logistics 3311 Export/Import Operations & Practices',
        'credit': '3'
      },
      {
        'course':
            'Transportation & International Logistics 3340 Business Logistics Management',
        'credit': '3'
      },
      {'course': 'Advanced Business Elective', 'credit': '3'},
      {'course': 'Advanced Business Elective', 'credit': '3'},
      {
        'course': 'Business Administration 4390 Business Strategy',
        'credit': '3'
      },
      {'course': 'Production & Operations Management 3310', 'credit': '3'},
      {
        'course':
            'Transportation & International Logistics 3360 Supply Chain Security & Compliance',
        'credit': '3'
      },
      {'course': 'Advanced Business Elective', 'credit': '3'},
    ],
    'Biology (BA)': [
      {'course': 'BIOL 1306 Principles of Biology I', 'credit': '3'},
      {'course': 'BIOL 1106 Principles of Biology I-Lab', 'credit': '1'},
      {'course': 'CHEM 1311 General Chemistry I', 'credit': '3'},
      {'course': 'CHEM 1111 General Chemistry I-Lab', 'credit': '1'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'BIOL - Biology Elective', 'credit': '4'},
      {'course': 'CHEM 1412 General Chemistry II', 'credit': '4'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'CHEM 2423 Organic Chemistry I', 'credit': '4'},
      {'course': 'BIOL - Biology Elective', 'credit': '4'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'MATH 2412 Pre-Calculus', 'credit': '4'},
      {'course': 'CHEM 2425 Organic Chemistry II', 'credit': '4'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'Soc/Behavioral Science', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'BIOL 3413 Intro to Genetics', 'credit': '4'},
      {'course': 'BIOL 4170 Biology Seminar', 'credit': '1'},
      {'course': 'PHYS 1301 General Physics I', 'credit': '3'},
      {'course': 'PHYS 1101 General Physics I Lab', 'credit': '1'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'BIOL 3410 Ecology', 'credit': '4'},
      {'course': 'BIOL - Advanced Biology Elective', 'credit': '4'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'BIOL - Advanced Biology Elective', 'credit': '4'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'}
    ],
    'Biology (BS)': [
      {'course': 'BIOL 1306 Principles of Biology I', 'credit': '3'},
      {'course': 'BIOL 1106 Principles of Biology I-Lab', 'credit': '1'},
      {'course': 'CHEM 1311 General Chemistry I', 'credit': '3'},
      {'course': 'CHEM 1111 General Chemistry I-Lab', 'credit': '1'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'MATH 2412 Pre-Calculus', 'credit': '4'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'BIOL 1111 Principles of Biology II-Lab', 'credit': '1'},
      {'course': 'BIOL 1311 Principles of Biology II', 'credit': '3'},
      {'course': 'CHEM 1412 General Chemistry II', 'credit': '4'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'BIOL 1413 Principles of Biology III', 'credit': '4'},
      {'course': 'CHEM 2423 Organic Chemistry I', 'credit': '4'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'BIOL 2421 General Microbiology', 'credit': '4'},
      {'course': 'CHEM 2425 Organic Chemistry II', 'credit': '4'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'BIOL 3406 Evolution', 'credit': '4'},
      {'course': 'BIOL 3413 Intro to Genetics', 'credit': '4'},
      {'course': 'PHYS 1301 General Physics I', 'credit': '3'},
      {'course': 'PHYS 1101 General Physics I Lab', 'credit': '1'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'BIOL 3410 Ecology', 'credit': '4'},
      {'course': 'BIOL 3412 Cell Biology', 'credit': '4'},
      {'course': 'PHYS 1302 General Physics II', 'credit': '3'},
      {'course': 'PHYS 1102 General Physics II Lab', 'credit': '1'},
      {'course': 'Soc/Behavioral Science', 'credit': '3'},
      {'course': 'BIOL - Restricted Biology Elective', 'credit': '4'},
      {'course': 'BIOL - Restricted Biology Elective', 'credit': '4'},
      {'course': 'BIOL - Restricted Biology Elective', 'credit': '4'},
      {'course': 'Advanced Elective', 'credit': '3'},
      {'course': 'BIOL 4170 Biology Seminar', 'credit': '1'},
      {'course': 'BIOL - Restricted Biology Elective', 'credit': '4'},
      {'course': 'BIOL - Restricted Biology Elective', 'credit': '4'},
      {'course': 'BIOL - Restricted Biology Elective', 'credit': '2'},
      {'course': 'Advanced Elective', 'credit': '3'}
    ],
    'Chemistry (BS)': [
      {'course': 'BIOL 1306 Principles of Biology I', 'credit': '3'},
      {'course': 'BIOL 1106 Principles of Biology I-Lab', 'credit': '1'},
      {'course': 'CHEM 1311 General Chemistry I', 'credit': '3'},
      {'course': 'CHEM 1111 General Chemistry I-Lab', 'credit': '1'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'CHEM 1412 General Chemistry II', 'credit': '4'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'MATH 2413 Calculus I', 'credit': '4'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'CHEM 2423 Organic Chemistry I', 'credit': '4'},
      {
        'course':
            'PHYS 1301 or PHYS 2325 General Physics I or University Physics I',
        'credit': '3'
      },
      {
        'course':
            'PHYS 1101 or PHYS 2125 General Physics I Lab or University Physics I Lab',
        'credit': '1'
      },
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'Social/Behavioral Science', 'credit': '3'},
      {'course': 'CHEM 2425 Organic Chemistry II', 'credit': '4'},
      {
        'course':
            'PHYS 1302 or PHYS 2326 General Physics II or University Physics II',
        'credit': '3'
      },
      {
        'course':
            'PHYS 1102 or PHYS 2126 General Physics II Lab or University Physics II Lab',
        'credit': '1'
      },
      {'course': 'MATH 2414 Calculus II', 'credit': '4'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'CHEM 3405 Analytical Chemistry', 'credit': '4'},
      {'course': 'CHEM 3451 Biochemistry I', 'credit': '4'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Minor Elective', 'credit': '3'},
      {'course': 'CHEM 4198 Investigations in Chemistry', 'credit': '1'},
      {'course': 'CHEM - Advanced Chemistry Elective 1', 'credit': '4'},
      {'course': 'MATH 3330 Ordinary Differential Equations', 'credit': '3'},
      {'course': 'Minor Elective', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'CHEM 3431 Physical Chemistry I', 'credit': '4'},
      {'course': 'CHEM 4120 Chemistry Seminar', 'credit': '1'},
      {'course': 'CHEM 4411 Inorganic Chemistry', 'credit': '4'},
      {'course': 'Advance Minor Elective', 'credit': '3'},
      {'course': 'Advance Minor Elective', 'credit': '3'},
      {'course': 'CHEM 4120 Chemistry Seminar', 'credit': '1'},
      {'course': 'CHEM - Advanced Chemistry Elective 1', 'credit': '4'},
      {'course': 'CHEM - Advanced Chemistry Elective 1', 'credit': '4'},
      {'course': 'Advance Minor Elective', 'credit': '3'},
      {'course': 'Advance Minor Elective', 'credit': '3'}
    ],
    'Science with Grades 7-12 Certification (BS)': [
      {'course': 'BIOL 1306 Principles of Biology I', 'credit': '3'},
      {'course': 'BIOL 1106 Principles of Biology I-Lab', 'credit': '1'},
      {'course': 'CHEM 1311 General Chemistry I', 'credit': '3'},
      {'course': 'CHEM 1111 General Chemistry I-Lab', 'credit': '1'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'BIOL - Biology Elective', 'credit': '4'},
      {'course': 'CHEM 1412 General Chemistry II', 'credit': '4'},
      {'course': 'EDCI 1102 Intro to Teaching Profession', 'credit': '1'},
      {'course': 'MATH 2412 Pre-Calculus', 'credit': '4'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'CHEM 2423 Organic Chemistry I', 'credit': '4'},
      {'course': 'EDCI 2224 Cultural Foundations of Education', 'credit': '2'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'PHYS 1301 General Physics I', 'credit': '3'},
      {'course': 'PHYS 1101 General Physics I Lab', 'credit': '1'},
      {'course': 'PSYC 2314 Lifespan Growth and Development', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'PHYS 1302 General Physics II', 'credit': '3'},
      {'course': 'PHYS 1102 General Physics II Lab', 'credit': '1'},
      {
        'course': 'EDCI 3200 Survey of Content Knowledge and Experience',
        'credit': '2'
      },
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'BIOL 3413 Intro to Genetics', 'credit': '4'},
      {
        'course': 'EDCI 3301 Assessment for Instructional Design',
        'credit': '3'
      },
      {'course': 'EDCI 3302 Teaching English Language Learners', 'credit': '3'},
      {'course': 'GEOL 1303 Intro to Physical Geology', 'credit': '3'},
      {'course': 'GEOL 1103 Intro to Physical Geology Lab', 'credit': '1'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'BIOL 3410 Ecology', 'credit': '4'},
      {'course': 'BIOL 3412 Cell Biology', 'credit': '4'},
      {'course': 'EDRD 3320 Content Reading', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'BIOL 3406 Evolution', 'credit': '4'},
      {
        'course':
            'EDCI 3315 Implementing Effective Instructional Strategies for Diverse Learners',
        'credit': '3'
      },
      {'course': 'EDCI 4310 Engaging Learners', 'credit': '3'},
      {'course': 'Science Elective', 'credit': '4'},
      {'course': 'EDCI 4693 Clinical Teaching', 'credit': '6'},
      {
        'course':
            'EDSE 4350 Inclusive Practices for Children and Youth with Disabilities',
        'credit': '3'
      },
    ],
    'Computer Engineering (BS)': [
      {'course': 'CSCE 1136 Fundamentals of Programming Lab', 'credit': '1'},
      {'course': 'CSCE 1336 Fundamentals of Programming', 'credit': '3'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'ENGR 1201 Foundations of Engineering I', 'credit': '2'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 2413 Calculus I', 'credit': '4'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'ENGL 2311 Technical Communication-WIN', 'credit': '3'},
      {'course': 'ENGR 1304 Computer-Aided Design', 'credit': '3'},
      {'course': 'MATH 2414 Calculus II', 'credit': '4'},
      {'course': 'PHYS 2125 University Physics I Lab', 'credit': '1'},
      {'course': 'PHYS 2325 University Physics I', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'CSCE 1137 Object-Oriented Programming Lab', 'credit': '1'},
      {'course': 'CSCE 1337 Object-Oriented Programming', 'credit': '3'},
      {'course': 'CSCE 2330 Digital Logic Design', 'credit': '3'},
      {
        'course': 'ENGR 2105 Principles of Electrical Engineering Lab',
        'credit': '1'
      },
      {
        'course': 'ENGR 2305 Principles of Electrical Engineering',
        'credit': '3'
      },
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'MATH 2415 Calculus III', 'credit': '4'},
      {'course': 'ENGR 2372 Engineering Statistics', 'credit': '3'},
      {'course': 'MATH 3310 Introduction to Linear Algebra', 'credit': '3'},
      {'course': 'MATH 3330 Ordinary Differential Equations', 'credit': '3'},
      {'course': 'MATH 3365 Discrete Mathematics', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'CHEM 1111 General Chemistry I-Lab', 'credit': '1'},
      {'course': 'CHEM 1311 General Chemistry I', 'credit': '3'},
      {'course': 'CSCE 3301 Algorithms & Data Structures', 'credit': '3'},
      {'course': 'CSCE 3320 Signals and Systems', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'Language, Philosophy, and Culture', 'credit': '3'},
      {
        'course': 'CSCE 3314 Electronic Devices and Applications',
        'credit': '3'
      },
      {'course': 'CSCE 3335 Networks and Data Communication', 'credit': '3'},
      {'course': 'CSCE 3340 Microprocessor Systems', 'credit': '3'},
      {'course': 'CSCE 3345 Robotics and Automation', 'credit': '3'},
      {'course': 'CSCE 4301 Software Engineering', 'credit': '3'},
      {'course': 'CSCE 4300 Digital Electronic Circuit Design', 'credit': '3'},
      {'course': 'CSCE 4315 Embedded Systems', 'credit': '3'},
      {'course': 'CSCE 4320 Computer System Architecture', 'credit': '3'},
      {'course': 'CSCE 4380 Senior Design I-WIN', 'credit': '3'},
      {'course': 'Social & Behavioral Sciences', 'credit': '3'},
      {'course': 'ENGR 3300 Engineering Economics', 'credit': '3'},
      {'course': 'CSCE 4326 Operating Systems', 'credit': '3'},
      {'course': 'CSCE 4390 Senior Design II', 'credit': '3'},
      {'course': 'Advanced CSCE Elective', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
    ],
    'Petroleum Engineering (BS)': [
      {'course': 'CHEM 1111 General Chemistry I-Lab', 'credit': '1'},
      {'course': 'CHEM 1311 General Chemistry I', 'credit': '3'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'ENGR 1201 Foundations of Engineering I', 'credit': '2'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 2413 Calculus I', 'credit': '4'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'ENGL 2311 Technical Communication-WIN', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'PHYS 2125 University Physics I Lab', 'credit': '1'},
      {'course': 'PHYS 2325 University Physics I', 'credit': '3'},
      {'course': 'MATH 2414 Calculus II', 'credit': '4'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'ENGR 2103 Statics & Dynamics Lab', 'credit': '1'},
      {'course': 'ENGR 2303 Statics & Dynamics', 'credit': '3'},
      {'course': 'ENGR 2360 Thermodynamics & Fluid Mechanics', 'credit': '3'},
      {'course': 'MATH 2415 Calculus III', 'credit': '4'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'PHYS 2126 University Physics II Lab', 'credit': '1'},
      {'course': 'PHYS 2326 University Physics II', 'credit': '3'},
      {
        'course': 'ENGR 2105 Principles of Electrical Engineering Lab',
        'credit': '1'
      },
      {
        'course': 'ENGR 2305 Principles of Electrical Engineering',
        'credit': '3'
      },
      {'course': 'ENGR 2372 Engineering Statistics', 'credit': '3'},
      {'course': 'ENGR 2390 Mechanics of Materials', 'credit': '3'},
      {'course': 'GEOL 3420 Petroleum Geology', 'credit': '4'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'PETE 3110 Petrophysics Lab', 'credit': '1'},
      {'course': 'PETE 3310 Petrophysics', 'credit': '3'},
      {'course': 'PETE 3111 Well Log & Formation Eval Lab', 'credit': '1'},
      {'course': 'PETE 3311 Well Log & Formation Evaluation', 'credit': '3'},
      {'course': 'PETE 3330 Reservoir Fluids', 'credit': '3'},
      {'course': 'MATH 3330 Ordinary Differential Equations', 'credit': '3'},
      {'course': 'CSCE 1136 Fundamentals of Programming Lab', 'credit': '1'},
      {'course': 'CSCE 1336 Fundamentals of Programming', 'credit': '3'},
      {'course': 'PETE 3101 Drilling Engineering I Lab', 'credit': '1'},
      {'course': 'PETE 3301 Drilling Engineering I', 'credit': '3'},
      {'course': 'PETE 3307 Reservoir Engineering I', 'credit': '3'},
      {
        'course': 'PETE 3120 Petroleum Production Engineering I Lab',
        'credit': '1'
      },
      {'course': 'PETE 3320 Petroleum Production Engineering I', 'credit': '3'},
      {'course': 'ENGR 1304 Computer-Aided Design', 'credit': '3'},
      {'course': 'ENGR 3300 Engineering Economics', 'credit': '3'},
      {'course': 'PETE 4190 Senior Design I', 'credit': '1'},
      {
        'course': 'PETE 4321 Petroleum Production Engineering II',
        'credit': '3'
      },
      {'course': 'PETE 4370 Well Testing', 'credit': '3'},
      {'course': 'Language, Philosophy, and Culture', 'credit': '3'},
      {'course': 'PETE 4290 Senior Design II', 'credit': '2'},
      {'course': 'PETE 4382 Reservoir Modeling & Simulation', 'credit': '3'},
      {'course': 'Advanced PETE Elective', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Social & Behavioral Sciences', 'credit': '3'},
    ],
    'Systems Engineering (BS)': [
      {'course': 'CSCE 1136 Funds of Programming Lab', 'credit': '1'},
      {'course': 'CSCE 1336 Fundamentals of Programming', 'credit': '3'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'ENGR 1201 Foundations of Engineering I', 'credit': '2'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 2413 Calculus I', 'credit': '4'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'ENGL 2311 Technical Communication-WIN', 'credit': '3'},
      {'course': 'ENGR 1304 Computer-Aided Design', 'credit': '3'},
      {'course': 'MATH 2414 Calculus II', 'credit': '4'},
      {'course': 'PHYS 2125 University Physics I Lab', 'credit': '1'},
      {'course': 'PHYS 2325 University Physics I', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'CSCE 1137 Object-Oriented Programming Lab', 'credit': '1'},
      {'course': 'CSCE 1337 Object-Oriented Programming', 'credit': '3'},
      {'course': 'ENGR 2103 Statics & Dynamics Lab', 'credit': '1'},
      {'course': 'ENGR 2303 Statics & Dynamics', 'credit': '3'},
      {'course': 'ENGR 3300 Engineering Economics', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'MATH 2415 Calculus III', 'credit': '4'},
      {'course': 'CSCE 2330 Digital Logic Design', 'credit': '3'},
      {
        'course': 'ENGR 2105 Principles of Electrical Engineering Lab',
        'credit': '1'
      },
      {
        'course': 'ENGR 2305 Principles of Electrical Engineering',
        'credit': '3'
      },
      {'course': 'ENGR 2372 Engineering Statistics', 'credit': '3'},
      {'course': 'MATH 3310 Introduction to Linear Algebra', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'MATH 3330 Ordinary Differential Equations', 'credit': '3'},
      {'course': 'PHYS 2126 University Physics II Lab', 'credit': '1'},
      {'course': 'PHYS 2326 University Physics II', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'SENG 3320 Engineering Modeling & Design', 'credit': '3'},
      {'course': 'SENG 3380 Measurements and Devices', 'credit': '3'},
      {'course': 'ENGR 2360 Thermodynamics & Fluid Mechanics', 'credit': '3'},
      {'course': 'SENG 3330 Operations Research I', 'credit': '3'},
      {'course': 'SENG 3340 Robotics and Automation', 'credit': '3'},
      {'course': 'SENG 3345 Microprocessor Systems', 'credit': '3'},
      {'course': 'SENG 3370 Computer Integrated Manufacturing', 'credit': '3'},
      {'course': 'Language, Philosophy, and Culture', 'credit': '3'},
      {'course': 'SENG 4301 Senior Design I', 'credit': '3'},
      {'course': 'SENG 4315 Embedded Systems', 'credit': '3'},
      {'course': 'SENG 4360 Systems Simulation', 'credit': '3'},
      {'course': 'SENG Advanced Elective', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {
        'course': 'GEOL 4450 Geo Information Science for Engineering',
        'credit': '4'
      },
      {'course': 'SENG 4350 Facilities Design & Logistics', 'credit': '3'},
      {'course': 'SENG 4390 Senior Design II', 'credit': '3'},
    ],
    'Art (BA)': [
      {'course': 'ARTS 1311 Design I for Art Majors/Minors', 'credit': '3'},
      {'course': 'ARTS 1316 Drawing I', 'credit': '3'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Mathematics Core Course', 'credit': '3'},
      {'course': 'ARTS 1312 Design II', 'credit': '3'},
      {'course': 'ARTS 1317 Drawing II', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {
        'course': 'ARTS 1303 Art History Survey: Prehistory-Renaissance',
        'credit': '3'
      },
      {'course': 'ARTS - Intro to Art Media', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'Language, Philosophy, & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {
        'course': 'ARTS 1304 Art History Survey: Renaissance-Modern',
        'credit': '3'
      },
      {'course': 'ARTS - Intro to Art Media', 'credit': '3'},
      {'course': 'ARTS - Advanced Art Media', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'ARTS - Advanced Art Media', 'credit': '3'},
      {'course': 'ARTS - Art History Elective', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'Social/Behavioral Science', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'ARTS - Advanced Art Media', 'credit': '3'},
      {'course': 'ARTS - Art History Elective', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'ARTS 3353 Art Since 1945', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'ARTS 4333 Practicum Seminar in the Arts', 'credit': '3'},
      {'course': 'ARTS - Advanced Art Media', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
    ],
    'Art with All Level Certification (BA)': [
      {'course': 'ARTS 1311 Design I for Art Majors/Minors', 'credit': '3'},
      {'course': 'ARTS 1316 Drawing I', 'credit': '3'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Mathematics Core Course', 'credit': '3'},
      {'course': 'ARTS 1312 Design II', 'credit': '3'},
      {'course': 'ARTS 1317 Drawing II', 'credit': '3'},
      {'course': 'EDCI 1102 Intro to Teaching Profession', 'credit': '1'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'ARTS - Intro to Art Media', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'EDCI 2224 Cultural Foundations of Ed', 'credit': '2'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {
        'course': 'ARTS 1304 Art History Survey: Renaissance-Modern',
        'credit': '3'
      },
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {
        'course': 'EDCI 3200 Survey of Content Knowledge & Experience',
        'credit': '2'
      },
      {'course': 'ARTS - Intro to Art Media', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {
        'course': 'ARTS 1303 Art History Survey: Prehistory-Renaissance',
        'credit': '3'
      },
      {
        'course': 'EDCI 3301 Assessment for Instructional Design',
        'credit': '3'
      },
      {'course': 'EDCI 3302 Teaching English Language Learners', 'credit': '3'},
      {'course': 'ARTS - Advanced Art Media', 'credit': '3'},
      {'course': 'ARTS - Advanced Art Media', 'credit': '3'},
      {'course': 'ARTS - Advanced Art Media', 'credit': '3'},
      {'course': 'ARTS - Advanced Art History Elective', 'credit': '3'},
      {'course': 'ARTS - Advanced Art History Elective', 'credit': '3'},
      {'course': 'EDRD 3320 Content Reading', 'credit': '3'},
      {'course': 'ARTS - Advanced Art Media', 'credit': '3'},
      {'course': 'ARTS - Art History Elective', 'credit': '3'},
      {
        'course':
            'EDCI 3315 Implementing Effective Instructional Strategies for Diverse Learners',
        'credit': '3'
      },
      {'course': 'EDCI 4310 Engaging Learners', 'credit': '3'},
      {'course': 'EDCI 4693 Clinical Teaching', 'credit': '6'},
      {
        'course':
            'EDSE 4350 Inclusion Practices for Children & Youth with Disabilities',
        'credit': '3'
      },
    ],
    'Music in Performance (BM)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'Mathematics Core Course', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {
        'course': 'MUAP 1213 Applied Music Instrument (with 1010)',
        'credit': '2'
      },
      {'course': 'MUSI 1116 Aural Training I', 'credit': '1'},
      {'course': 'MUSI 1181 Piano Class I', 'credit': '1'},
      {'course': 'MUSI 1311 Music Theory I', 'credit': '3'},
      {'course': 'MUEN 11XX Large Ensemble', 'credit': '1'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {
        'course': 'MUAP 1213 Applied Music Instrument (with 1010)',
        'credit': '2'
      },
      {'course': 'MUSI 1117 Aural Training II', 'credit': '1'},
      {'course': 'MUSI 1182 Piano Class II', 'credit': '1'},
      {'course': 'MUSI 1312 Music Theory II', 'credit': '3'},
      {'course': 'MUEN 11XX Large Ensemble', 'credit': '1'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {
        'course': 'MUAP 1213 Applied Music Instrument (with 1010)',
        'credit': '2'
      },
      {'course': 'MUSI 2116 Aural Training III', 'credit': '1'},
      {'course': 'MUSI 2181 Piano Class III', 'credit': '1'},
      {'course': 'MUSI 2311 Music Theory III', 'credit': '3'},
      {'course': 'MUEN 11XX Large Ensemble', 'credit': '1'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Social/Behavioral Science', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {
        'course': 'MUAP 1213 Applied Music Instrument (with 1010)',
        'credit': '2'
      },
      {'course': 'MUSI 2117 Aural Training IV', 'credit': '1'},
      {'course': 'MUSI 2182 Piano Class IV', 'credit': '1'},
      {'course': 'MUSI 2312 Music Theory IV', 'credit': '3'},
      {'course': 'MUEN 11XX Large Ensemble', 'credit': '1'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Language, Philosophy, & Culture', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {
        'course': 'MUAP 3213 Applied Music Instrument (with 3010)',
        'credit': '2'
      },
      {'course': 'MUEN 1150 Chamber Music', 'credit': '1'},
      {'course': 'MUSI 3303 Computer/Electronic Music', 'credit': '3'},
      {'course': 'MUSI 3300 Music History I', 'credit': '3'},
      {'course': 'MUEN 31XX Large Ensemble', 'credit': '1'},
      {'course': 'Advanced Fine Arts Elective', 'credit': '3'},
      {
        'course': 'MUAP 3213 Applied Music Instrument (with 3010)',
        'credit': '2'
      },
      {'course': 'MUEN 3150 Chamber Music', 'credit': '1'},
      {'course': 'MUSI 3253 Basic Conducting', 'credit': '2'},
      {'course': 'MUSI 3301 Music History II', 'credit': '3'},
      {'course': 'MUEN 31XX Large Ensemble', 'credit': '1'},
      {'course': 'Advanced Fine Arts Elective', 'credit': '2'},
      {
        'course': 'MUAP 3213 Applied Music Instrument (with 3010)',
        'credit': '2'
      },
      {'course': 'MUEN 3150 Chamber Music', 'credit': '1'},
      {'course': 'MUSI 3347 Counterpoint', 'credit': '3'},
      {
        'course': 'MUSI 4260 Instrumental Literature & Teaching Techniques',
        'credit': '2'
      },
      {'course': 'MUEN 31XX Large Ensemble', 'credit': '1'},
      {'course': 'Advanced Fine Arts Elective', 'credit': '2'},
      {
        'course': 'MUAP 3213 Applied Music Instrument (with 3010)',
        'credit': '2'
      },
      {'course': 'MUAP 4105 Senior Performance', 'credit': '1'},
      {'course': 'MUEN 3150 Chamber Music', 'credit': '1'},
      {'course': 'MUSI 3346 Form and Analysis', 'credit': '3'},
      {'course': 'MUEN 31XX Large Ensemble', 'credit': '1'},
      {'course': 'Advanced Fine Arts Elective', 'credit': '3'},
    ],
    'Music with All Level Certification (BM)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'Mathematics Core Course', 'credit': '3'},
      {'course': 'EDCI 1102 Intro to Teaching Profession', 'credit': '1'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {
        'course': 'MUAP 1213 Applied Music Instrument (with MUAP 1010)',
        'credit': '2'
      },
      {'course': 'MUSI 1116 Aural Training I', 'credit': '1'},
      {'course': 'MUSI 1181 Piano Class I', 'credit': '1'},
      {'course': 'MUSI 1211 Music Theory I', 'credit': '2'},
      {'course': 'MUSI 11XX Large Ensemble', 'credit': '1'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {
        'course': 'MUAP 1213 Applied Music Instrument (with MUAP 1010)',
        'credit': '2'
      },
      {'course': 'MUSI 1117 Aural Training II', 'credit': '1'},
      {'course': 'MUSI 1182 Piano Class II', 'credit': '1'},
      {'course': 'MUSI 1212 Music Theory II', 'credit': '2'},
      {'course': 'MUSI 11XX Large Ensemble', 'credit': '1'},
      {'course': 'EDCI 2224 Cultural Foundations of Education', 'credit': '2'},
      {'course': 'MUSI 2116 Aural Training III', 'credit': '1'},
      {'course': 'MUSI 2181 Piano Class III', 'credit': '1'},
      {'course': 'MUSI 2211 Music Theory III', 'credit': '2'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'MUSI 11XX Large Ensemble', 'credit': '1'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Creative Arts', 'credit': '3'},
      {
        'course': 'EDCI 3200 Survey of Content Knowledge & Experience',
        'credit': '2'
      },
      {
        'course': 'MUAP 1213 Applied Music Instrument (with MUAP 1010)',
        'credit': '2'
      },
      {'course': 'MUSI 2117 Aural Training IV', 'credit': '1'},
      {'course': 'MUSI 2182 Piano Class IV', 'credit': '1'},
      {'course': 'MUSI 2212 Music Theory IV', 'credit': '2'},
      {'course': 'MUSI 11XX Large Ensemble', 'credit': '1'},
      {'course': 'Social/Behavioral Science 1', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Language, Philosophy, & Culture', 'credit': '3'},
      {'course': 'EDCI 3302 Teaching English Language Learners', 'credit': '3'},
      {
        'course': 'MUAP 3213 Applied Music Instrument (with MUAP 3010)',
        'credit': '2'
      },
      {'course': 'MUSI 1302 Computer/Electronic Music', 'credit': '3'},
      {'course': 'MUSI 3133 Elementary Music', 'credit': '1'},
      {'course': 'MUSI 3253 Basic Conducting', 'credit': '2'},
      {'course': 'MUSI 3300 Music History I', 'credit': '3'},
      {'course': 'MUSI 31XX Large Ensemble', 'credit': '1'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'EDRD 3320 Content Reading', 'credit': '3'},
      {
        'course': 'MUAP 3213 Applied Music Instrument (with MUAP 3010)',
        'credit': '2'
      },
      {'course': 'MUSI 3183 Voice Methods', 'credit': '1'},
      {'course': 'MUSI 3346 Form and Analysis', 'credit': '3'},
      {'course': 'MUSI 4233 Secondary Music', 'credit': '2'},
      {
        'course': 'MUSI 4260 Instrumental Literature & Teaching Techniques',
        'credit': '2'
      },
      {'course': 'MUSI 31XX Large Ensemble', 'credit': '1'},
      {'course': 'MUSI - Additional Pedagogy', 'credit': '1'},
      {
        'course':
            'EDCI 3315 Implementing Effective Instructional Strategies for Diverse Learners',
        'credit': '3'
      },
      {'course': 'EDCI 4310 Engaging Learners', 'credit': '3'},
      {
        'course': 'MUAP 3213 Applied Music Instrument (with MUAP 3010)',
        'credit': '2'
      },
      {'course': 'MUSI 3301 Music History II', 'credit': '3'},
      {'course': 'MUSI - Additional Pedagogy', 'credit': '1'},
      {'course': 'MUSI 31XX Large Ensemble', 'credit': '1'},
      {'course': 'MUSI 3254 Advanced Conducting', 'credit': '2'},
      {'course': 'MUAP 4105 Senior Performance', 'credit': '1'},
      {
        'course':
            'EDSE 4350 Instructional Practicum for Children & Youth with Disabilities',
        'credit': '3'
      },
      {'course': 'MUSI 3201 Score Arranging', 'credit': '2'},
      {'course': 'MUSI 4693 Music Student Teaching', 'credit': '6'},
      {'course': 'MUSI - Additional Pedagogy', 'credit': '1'},
    ],
    'Communication and Spanish (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Second Romance Language', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'COMM 3325 Mass Communication', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'SPAN 2350 Intro to the Hispanic World', 'credit': '3'},
      {'course': 'Second Romance Language', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'COMM 1326 Journalistic Writing', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'SPAN 3305 Spanish Academic Writing', 'credit': '3'},
      {'course': 'Soc/Behavioral Science', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'COMM 3322 Public Relations', 'credit': '3'},
      {'course': 'COMM 3327 Media Writing', 'credit': '3'},
      {'course': 'SPAN 3310 Intro to Literature in Spanish', 'credit': '3'},
      {
        'course': 'SPAN 3351 Intro to English-Spanish Translation',
        'credit': '3'
      },
      {'course': 'SPAN - Adv SPAN Elective', 'credit': '3'},
      {'course': 'COMM 3329 Fundamentals of Advertising', 'credit': '3'},
      {
        'course': 'COMM 4320 Trends in International Communication',
        'credit': '3'
      },
      {'course': 'COMM 4340 Communication Ethics', 'credit': '3'},
      {'course': 'SPAN - Adv SPAN Elective', 'credit': '3'},
      {'course': 'SPAN - Adv SPAN Elective', 'credit': '3'},
      {
        'course': 'COMM 3310 Methods of Inquiry: Quantitative Research',
        'credit': '3'
      },
      {'course': 'COMM 4360 Communication Theory & Practice', 'credit': '3'},
      {'course': 'SPAN 4398 Creative Writing', 'credit': '3'},
      {'course': 'SPAN - Adv SPAN Elective', 'credit': '3'},
      {'course': 'COMM 4324 Comparative Journalism', 'credit': '3'},
      {'course': 'COMM 4350 Internship', 'credit': '3'},
      {
        'course': 'SPAN 4330 Special Topics in Spanish Literature & Culture',
        'credit': '3'
      },
    ],
    'English (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Mathematics Core Course', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Language, Philosophy, and Culture', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'ENGL - Survey of Literature', 'credit': '3'},
      {'course': 'General Elective', 'credit': '2'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'Soc/Behavioral Science', 'credit': '3'},
      {'course': 'ENGL - Survey of Literature', 'credit': '3'},
      {'course': 'ENGL - Advanced English Lit Elective', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'ENGL - Advanced American Lit Elective', 'credit': '3'},
      {'course': 'ENGL - Advanced British Lit Elective', 'credit': '3'},
      {'course': 'ENGL - Advanced English Lit. Elective', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {
        'course':
            'ENGL 4313 or ENGL 3390 Advanced English Grammar or History of the English Lang',
        'credit': '3'
      },
      {'course': 'ENGL - Advanced American Lit Elective', 'credit': '3'},
      {'course': 'ENGL - Advanced British Lit Elective', 'credit': '3'},
      {'course': 'ENGL - Shakespeare 1', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'ENGL 4399 Senior Seminar - WIN 2', 'credit': '3'},
      {'course': 'ENGL - Advanced English Lit. Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
    ],
    'English with Grade 7-12 Certification (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Mathematics Core Course', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'EDCI 1102 Intro to Teaching Profession', 'credit': '1'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'EDCI 2224 Cultural Foundations of Ed', 'credit': '2'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'Language, Philosophy, & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'EDCI 3200 Survey of Content Know & Exper', 'credit': '2'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'ENGL - Survey of Literature', 'credit': '3'},
      {'course': 'ENGL - Survey of Literature', 'credit': '3'},
      {'course': 'ENGL - Advanced English Elective', 'credit': '3'},
      {'course': 'EDCI 3301 Assessment for Instruc Design', 'credit': '3'},
      {'course': 'EDCI 3302 Teaching Eng Lang Learners', 'credit': '3'},
      {
        'course':
            'ENGL 3362 or ENGL 3361 Young Adult Literature or Multicultural Children\'s Lit',
        'credit': '3'
      },
      {'course': 'ENGL - Advanced American Lit Elective', 'credit': '3'},
      {'course': 'ENGL - Advanced British Lit Elective', 'credit': '3'},
      {'course': 'EDRD 3320 Content Reading', 'credit': '3'},
      {'course': 'ENGL 4301 The Teaching of Composition', 'credit': '3'},
      {'course': 'ENGL 4313 Advanced English Grammar', 'credit': '3'},
      {'course': 'ENGL - Shakespeare 2', 'credit': '3'},
      {'course': 'ENGL - Advanced English Elective', 'credit': '3'},
      {'course': 'EDCI 3315 Impl Eff Inst Strat Div Lrnrs', 'credit': '3'},
      {'course': 'EDCI 4310 Engaging Learners', 'credit': '3'},
      {'course': 'ENGL 4399 Senior Seminar - WIN 3', 'credit': '3'},
      {'course': 'ENGL - Advanced American Lit Elective', 'credit': '3'},
      {'course': 'ENGL - Advanced British Lit Elective', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'EDCI 4693 Clinical Teaching 4', 'credit': '6'},
      {'course': 'EDSE 4350 Inc Pract Ch&Yth W/Disablts', 'credit': '3'},
    ],
    'History (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'MATH Core Course', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'GEOG 1303 General World Geography', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'HIST 2321 Eastern Civilizations', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'HIST 2322 Western Civilization', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'HIST 3302 History of Texas', 'credit': '3'},
      {'course': 'HIST 3303 Historical Methods-WIN', 'credit': '3'},
      {'course': 'HIST - U.S. History Elective', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'HIST - U.S. History Elective', 'credit': '3'},
      {'course': 'HIST - International History Elective', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'HIST - International U.S. History Elective', 'credit': '3'},
      {'course': 'HIST - International U.S. History Elective', 'credit': '3'},
      {'course': 'HIST - U.S. History Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '2'},
      {'course': 'HIST 4310 Historical Perspectives-WIN', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
    ],
    'History and Political Science (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'MATH Core Course', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'HIST 2321 Eastern Civilizations', 'credit': '3'},
      {'course': 'PSCI 2301 Intro to Political Leadership', 'credit': '3'},
      {'course': 'GEOG 1303 General World Geography', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'HIST 2322 Western Civilization', 'credit': '3'},
      {'course': 'HIST - International History Elective', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '1'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'HIST 3302 History of Texas', 'credit': '3'},
      {'course': 'HIST 3303 Historical Methods-WIN', 'credit': '3'},
      {'course': 'PSCI 3301 Research Methods in Social Science', 'credit': '3'},
      {'course': 'PSCI - American Politics', 'credit': '3'},
      {'course': 'PSCI - American Politics', 'credit': '3'},
      {'course': 'HIST - U.S. History', 'credit': '3'},
      {'course': 'HIST - International History Elective', 'credit': '3'},
      {'course': 'PSCI - Constitutional Law', 'credit': '3'},
      {'course': 'PSCI - Political Philosophy', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'PSCI - Comparative Politics', 'credit': '3'},
      {'course': 'PSCI - International Politics', 'credit': '3'},
      {'course': 'HIST - International History Elective', 'credit': '3'},
      {'course': 'HIST - U.S. History', 'credit': '3'},
      {'course': 'General Elective', 'credit': '2'},
      {'course': 'PSCI 4351 Senior Seminar in PSCI', 'credit': '3'},
      {'course': 'HIST 4310 Historical Perspectives-WIN', 'credit': '3'},
      {'course': 'HIST - U.S. History', 'credit': '3'},
      {'course': 'PSCI - Advance PSCI Elective', 'credit': '3'},
    ],
    'History with Grades 7-12 Certification (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'MATH Core Course', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'EDCI 1102 Intro to Teaching Profession', 'credit': '1'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'HIST 2321 Eastern Civilizations', 'credit': '3'},
      {'course': 'EDCI 2224 Cultural Foundations of Ed', 'credit': '2'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'HIST 2322 Western Civilization', 'credit': '3'},
      {'course': 'EDCI 3200 Survey of Content Know & Exper', 'credit': '2'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'EDCI 3301 Assessment for Instruc Design', 'credit': '3'},
      {'course': 'EDCI 3302 Teaching Eng Lang Learners', 'credit': '3'},
      {'course': 'HIST 3302 History of Texas', 'credit': '3'},
      {'course': 'HIST 3303 Historical Methods-WIN', 'credit': '3'},
      {'course': 'HIST - International Hist Elective', 'credit': '3'},
      {'course': 'EDRD 3320 Content Reading', 'credit': '3'},
      {'course': 'HIST 4310 Historical Perspectives-WIN', 'credit': '3'},
      {'course': 'HIST - International Hist Elective', 'credit': '3'},
      {'course': 'HIST - U.S. History Elec', 'credit': '3'},
      {'course': 'HIST - U.S. History Elec', 'credit': '3'},
      {'course': 'EDCI 3315 Impl Eff Inst Strat Div Lrnrs', 'credit': '3'},
      {'course': 'EDCI 4310 Engaging Learners', 'credit': '3'},
      {'course': 'GEOG - Adv Geography', 'credit': '3'},
      {'course': 'HIST - U.S. History Elec', 'credit': '3'},
      {'course': 'HIST - International Hist Elective', 'credit': '3'},
      {'course': 'EDCI 4693 Clinical Teaching', 'credit': '6'},
      {'course': 'EDSE 4350 Inc Pract Ch&Yth W/Disablts', 'credit': '3'},
    ],
    'Spanish (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Mathematics Core Course', 'credit': '3'},
      {'course': 'Foreign Language 1', 'credit': '3'},
      {'course': 'General Elective 2', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'Foreign Language 1', 'credit': '3'},
      {'course': 'Social/Behavioral Science', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'SPAN 2350 Intro to the Hispanic World', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'SPAN 3305 Spanish Academic Writing', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'General Elective 2', 'credit': '2'},
      {'course': 'SPAN 3310 Intro to Literature in Spanish', 'credit': '3'},
      {'course': 'SPAN - Advanced SPAN Elective 3', 'credit': '3'},
      {'course': 'Advanced General Elective 2', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'SPAN 4303 The Spanish American Novel', 'credit': '3'},
      {'course': 'SPAN 4312 History of Spanish Language', 'credit': '3'},
      {'course': 'SPAN - Advanced SPAN Elective 3', 'credit': '3'},
      {'course': 'Advanced General Elective 2', 'credit': '3'},
      {'course': 'Advanced General Elective 2', 'credit': '3'},
      {'course': 'SPAN 4308 Cervantes & Don Quijote', 'credit': '3'},
      {'course': 'SPAN 4399 Senior Seminar', 'credit': '3'},
      {'course': 'SPAN - Advanced SPAN Elective 3', 'credit': '3'},
      {'course': 'Advanced General Elective 2', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'SPAN - Advanced SPAN Elective 3', 'credit': '3'},
      {'course': 'SPAN - Advanced SPAN Elective 3', 'credit': '3'},
      {'course': 'SPAN - Advanced SPAN Elective 3', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
    ],
    'Spanish with All Level Certification (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Mathematics Core Course', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Foreign Language *', 'credit': '3'},
      {'course': 'EDCI 1102 Intro to Teaching Profession', 'credit': '1'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Foreign Language *', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'EDCI 2224 Cultural Foundations of Ed', 'credit': '2'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'SPAN 2350 Intro to the Hispanic World', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'EDCI 3200 Survey of Content Know & Exper', 'credit': '2'},
      {'course': 'SPAN 3305 Spanish Academic Writing', 'credit': '3'},
      {'course': 'SPAN 3310 Intro to Literature in Spanish', 'credit': '3'},
      {'course': 'SPAN - Advanced Spanish Elective', 'credit': '3'},
      {'course': 'EDCI 3301 Assessment for Instruc Design', 'credit': '3'},
      {'course': 'EDCI 3302 Teaching Eng Lang Learners', 'credit': '3'},
      {'course': 'SPAN - Spanish Literature', 'credit': '3'},
      {'course': 'SPAN - Spanish Amer Lit', 'credit': '3'},
      {'course': 'SPAN - Spanish Linguistics', 'credit': '3'},
      {'course': 'EDRD 3320 Content Reading', 'credit': '3'},
      {'course': 'SPAN 4303 The Spanish American Novel', 'credit': '3'},
      {'course': 'SPAN 4311 Probs in Teaching of Span', 'credit': '3'},
      {'course': 'SPAN - Advanced Spanish Elective', 'credit': '3'},
      {'course': 'SPAN - Advanced Spanish Elective', 'credit': '3'},
      {'course': 'EDCI 3315 Impl Eff Inst Strat Div Lrnrs', 'credit': '3'},
      {'course': 'EDCI 4310 Engaging Learners', 'credit': '3'},
      {'course': 'SPAN 4308 Cervantes & Don Quijote', 'credit': '3'},
      {'course': 'SPAN 4399 Senior Seminar', 'credit': '3'},
      {'course': 'SPAN - Advanced Spanish Elective', 'credit': '3'},
      {'course': 'EDCI 4693 Clinical Teaching', 'credit': '6'},
      {'course': 'EDSE 4350 Inc Pract Ch&Yth W/Disablts', 'credit': '3'},
    ],
    'Mathematics (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 2413 Calculus I', 'credit': '4'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'MATH 2414 Calculus II', 'credit': '4'},
      {'course': 'CSCE 1336 Fundamentals of Programming', 'credit': '3'},
      {'course': 'CSCE 1136 Funds of Programming Lab', 'credit': '1'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'MATH 2415 Calculus III', 'credit': '4'},
      {'course': 'MATH 3365 Discrete Mathematics', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'MATH 3310 Introduction to Linear Algebra', 'credit': '3'},
      {'course': 'MATH 3360 Statistical Analysis', 'credit': '3'},
      {'course': 'Foreign Lang/Study Abroad', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'MATH 3330 Ordinary Diff Equations', 'credit': '3'},
      {'course': 'MATH 3371 Communications in Mathematics', 'credit': '3'},
      {'course': 'MATH 4335 Advanced Calculus', 'credit': '3'},
      {'course': 'Social/Behavioral Science', 'credit': '3'},
      {'course': 'Foreign Lang/Study Abroad', 'credit': '3'},
      {'course': 'MATH 4310 Abstract Algebra I', 'credit': '3'},
      {'course': 'Advanced Elective', 'credit': '3'},
      {'course': 'Advanced Elective', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'General Elective', 'credit': '4'},
      {'course': 'Advanced Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'MATH 4345 Complex Variables', 'credit': '3'},
      {'course': 'Advanced Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
    ],
    'Mathematics with Grades 7-12 Certification (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 2413 Calculus I', 'credit': '4'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'MATH 2414 Calculus II', 'credit': '4'},
      {'course': 'EDCI 1102 Intro to Teaching Profession', 'credit': '1'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'EDCI 2224 Cultural Foundations of Ed', 'credit': '2'},
      {'course': 'MATH 2415 Calculus III', 'credit': '4'},
      {'course': 'MATH 3365 Discrete Mathematics', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Language, Philosophy, & Culture', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'MATH 3310 Introduction to Linear Algebra', 'credit': '3'},
      {'course': 'EDCI 3200 Survey of Content Know & Exper', 'credit': '2'},
      {'course': 'CSCE 1336 Fundamentals of Programming', 'credit': '3'},
      {'course': 'CSCE 1136 Funds of Programming Lab', 'credit': '1'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'MATH 3371 Communications in Mathematics', 'credit': '3'},
      {'course': 'MATH 3360 Statistical Analysis', 'credit': '3'},
      {'course': 'MATH 3330 Ordinary Diff Equations', 'credit': '3'},
      {'course': 'EDCI 3301 Assessment for Instruc Design', 'credit': '3'},
      {'course': 'EDCI 3302 Teaching Eng Lang Learners', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'EDRD 3320 Content Reading', 'credit': '3'},
      {'course': 'MATH 3325 Geometry', 'credit': '3'},
      {'course': 'MATH 4310 Abstract Algebra I', 'credit': '3'},
      {'course': 'MATH 4335 Advanced Calculus', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'MATH 4390 Math in Middle & High School', 'credit': '3'},
      {'course': 'EDCI 3315 Impl Eff Inst Strat Div Lrnrs', 'credit': '3'},
      {'course': 'EDCI 4310 Engaging Learners', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '2'},
      {'course': 'EDSE 4350 Inc Pract Ch&Yth W/Disablts', 'credit': '3'},
      {'course': 'EDCI 4693 Clinical Teaching', 'credit': '6'}
    ],
    'Mathematics (BS)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 2413 Calculus I', 'credit': '4'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'MATH 2414 Calculus II', 'credit': '4'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'CSCE 1336 Fundamentals of Programming', 'credit': '3'},
      {'course': 'CSCE 1136 Funds of Programming Lab', 'credit': '1'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'MATH 2415 Calculus III', 'credit': '4'},
      {'course': 'MATH 3365 Discrete Mathematics', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'MATH 3310 Introduction to Linear Algebra', 'credit': '3'},
      {'course': 'MATH 3360 Statistical Analysis', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'MATH 3330 Ordinary Diff Equations', 'credit': '3'},
      {'course': 'MATH 3371 Communications in Mathematics', 'credit': '3'},
      {'course': 'MATH 4335 Advanced Calculus', 'credit': '3'},
      {'course': 'Foreign Lang/Study Abroad', 'credit': '3'},
      {'course': 'Social & Behavioral Science', 'credit': '3'},
      {'course': 'MATH 4310 Abstract Algebra I', 'credit': '3'},
      {'course': 'MATH - Advanced MATH Elective', 'credit': '3'},
      {'course': 'Foreign Lang/Study Abroad', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'MATH - Advanced Math Elective', 'credit': '3'},
      {'course': 'MATH - Advanced Math Elective', 'credit': '3'},
      {'course': 'MATH - Advanced Math Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'MATH 3195 Seminar (Free Elective)', 'credit': '1'},
      {'course': 'MATH 4345 Complex Variables', 'credit': '3'},
      {'course': 'MATH - Advanced Math Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'}
    ],
    'Communication (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'COMM Elective', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'Social/Behavioral Science', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'COMM Elective', 'credit': '3'},
      {'course': 'COMM Elective', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'COMM 3300 Intro to Theo Prin of Comm', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'COMM 3310 Methods of Inquiry: Quant Rsch', 'credit': '3'},
      {'course': 'COMM Elective', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '2'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'COMM 4360 Comm Theory & Practice', 'credit': '3'},
      {'course': 'COMM 3312 Methods of Inquiry: Qual Rsch', 'credit': '3'},
      {'course': 'Restrictive COMM Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '3'},
      {'course': 'COMM 4350 Internship', 'credit': '3'},
      {'course': 'Restrictive COMM Elective', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'}
    ],
    'Communication - Media Production (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'COMM Elective', 'credit': '3'},
      {'course': 'COMM 1311 Fundamentals of Comm', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'Social/Behavioral Science', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'COMM Elective', 'credit': '3'},
      {'course': 'COMM Elective', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'COMM 3300 Intro to Theo Prin of Comm', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'COMM 3310 Methods of Inquiry: Quant Rsch', 'credit': '3'},
      {'course': 'COMM Elective', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '2'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'COMM 4360 Comm Theory & Practice', 'credit': '3'},
      {'course': 'COMM 3312 Methods of Inquiry: Qual Rsch', 'credit': '3'},
      {'course': 'Restrictive COMM Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '3'},
      {'course': 'COMM 4350 Internship', 'credit': '3'},
      {'course': 'Restrictive COMM Elective', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'}
    ],
    'Psychology (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'PSYC 2301 Intro to Psychology', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'PSYC-1000-200 Restricted PSYC elective', 'credit': '3'},
      {'course': 'Social/Behavioral Science', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'PSYC 2317 Basic Stats for Psychology', 'credit': '3'},
      {'course': 'PSYC 2117 Basic Stats for Psyc Lab', 'credit': '1'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'PSYC 3302 Research Methods in Psyc', 'credit': '3'},
      {'course': 'PSYC 3102 Rsrch Methods in Beh Sci Lab', 'credit': '1'},
      {'course': 'PSYC-1000-2000 Restricted PSYC elective', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {
        'course': 'PSYC-1000-2000 Restricted Psychology elective',
        'credit': '3'
      },
      {
        'course': 'PSYC-3000-4000 Restricted Psychology elective',
        'credit': '3'
      },
      {
        'course': 'PSYC-3000-4000 Restricted Psychology elective',
        'credit': '3'
      },
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'PSYC 4325 Cognitive Psychology', 'credit': '3'},
      {
        'course': 'PSYC-3000-4000 Restricted Psychology elective',
        'credit': '3'
      },
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'PSYC 4301 Psychology of Personality', 'credit': '3'},
      {'course': 'Advanced General Elec', 'credit': '3'},
      {'course': 'Advanced General Elec', 'credit': '3'},
      {'course': 'Advanced General Elec', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'}
    ],
    'Applied Arts and Sciences (BAAS)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'MATH Core Course', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'General Elective', 'credit': '2'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Soc/Behavioral Science', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'Advanced Communication/English', 'credit': '3'},
      {'course': 'Advanced Social Science', 'credit': '3'},
      {'course': 'Advanced Social Science', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'Advanced Communication/English', 'credit': '3'},
      {'course': 'Advanced Communication/English', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Research Methods', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced Social Science', 'credit': '3'},
      {'course': 'COMM 4360 Comm Theory & Practice', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced Social Science', 'credit': '3'}
    ],
    'Applied Arts and Sciences Criminal Justice Concentration (BAAS)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 1314 College Algebra', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Soc/Behavioral Science', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'ENGL 3302 Writing in the Disciplines-WIN', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'VTF - Vocational Technical Field', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'SOCI 3336 Criminology', 'credit': '3'},
      {'course': 'Research Methods-WIN', 'credit': '3'},
      {'course': 'Advanced CRIJ Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'CRIJ 4325 Statistics in Criminal Justice', 'credit': '3'},
      {'course': 'Advanced CRIJ Elective', 'credit': '3'},
      {'course': 'Advanced CRIJ Elective', 'credit': '3'},
      {'course': 'Advanced CRIJ Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'CRIJ 4321 Senior Pro-Seminar-WIN (WIN)', 'credit': '3'},
      {'course': 'Advanced CRIJ Elective', 'credit': '3'},
      {'course': 'Advanced CRIJ Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'}
    ],
    'Criminal Justice and Political Science (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'GEOG 1303 General World Geography', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 1314 College Algebra', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'CRIJ 1301 Intro to Criminal Justice', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'CRIJ - Lower Level Elective', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'CRIJ 2329 Fundamentals of Criminal Law', 'credit': '3'},
      {
        'course':
            'PSCI 2301 or PSCI 2304 Intro to Political Leadership or Intro to Political Science',
        'credit': '3'
      },
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'SOCI 3336 Criminology', 'credit': '3'},
      {'course': 'CRIJ - Research Methods', 'credit': '3'},
      {'course': 'CRIJ - Advanced CRIJ Elective', 'credit': '3'},
      {'course': 'PSCI - American Politics', 'credit': '3'},
      {'course': 'PSCI - American Politics', 'credit': '3'},
      {'course': 'CRIJ 4325 Statistics in Criminal Justice', 'credit': '3'},
      {'course': 'CRIJ - Advanced CRIJ Elective', 'credit': '3'},
      {'course': 'PSCI - Constitutional Law', 'credit': '3'},
      {'course': 'PSCI - Political Philosophy', 'credit': '3'},
      {'course': 'PSCI - Comparative Politics', 'credit': '3'},
      {'course': 'CRIJ - Advanced CRIJ Elective', 'credit': '3'},
      {'course': 'PSCI - Advanced PSCI Elective', 'credit': '3'},
      {'course': 'PSCI - International Politics', 'credit': '3'},
      {'course': 'PSCI - International Politics', 'credit': '3'},
      {'course': 'General Elective', 'credit': '2'},
      {'course': 'CRIJ 4321 Senior Pro-Seminar-WIN', 'credit': '3'},
      {'course': 'PSCI 4351 Senior Seminar in PSCI', 'credit': '3'},
      {'course': 'CRIJ - Advanced CRIJ Elective', 'credit': '3'},
      {'course': 'PSCI - Advanced PSCI Elective', 'credit': '3'}
    ],
    'Political Science (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'GEOG 1303 General World Geography', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 1314 College Algebra', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {
        'course':
            'PSCI 2301 or PSCI 2304 Intro to Political Leadership or Intro to Political Science',
        'credit': '3'
      },
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'PSCI 3301 Research Methods in Social Sci', 'credit': '3'},
      {'course': 'PSCI - American Politics', 'credit': '3'},
      {'course': 'PSCI - American Politics', 'credit': '3'},
      {'course': 'General Elective', 'credit': '2'},
      {'course': 'Advanced Minor/Advanced General Elective', 'credit': '3'},
      {'course': 'PSCI - Constitutional Law', 'credit': '3'},
      {'course': 'PSCI - Political Philosophy', 'credit': '3'},
      {'course': 'PSCI - Advanced PSCI Elective', 'credit': '3'},
      {'course': 'Advanced Minor/Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'PSCI - Comparative Politics', 'credit': '3'},
      {'course': 'PSCI - International Politics', 'credit': '3'},
      {'course': 'PSCI - International Politics', 'credit': '3'},
      {'course': 'Advanced Minor/Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'PSCI 4351 Senior Seminar in PSCI', 'credit': '3'},
      {'course': 'PSCI - Advanced PSCI Elective', 'credit': '3'},
      {'course': 'Advanced Minor/Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'}
    ],
    'Sociology (BA)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {
        'course':
            'MATH 1314 or MATH 1332 College Algebra or Mathematics for Liberal Arts I',
        'credit': '3'
      },
      {'course': 'SOCI 1301 Intro to Sociology', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Social/Behavioral Science', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'SOCI 1306 Cont Social Prob&Social Pol', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'Foreign Language/Study Abroad', 'credit': '3'},
      {'course': 'General Elective', 'credit': '2'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'SOCI 2301 Marriage and Family', 'credit': '3'},
      {'course': 'SOCI 3304 Sociological Theory', 'credit': '3'},
      {'course': 'SOCI - Advanced SOCI Elective', 'credit': '3'},
      {'course': 'SOCI - Advanced SOCI Elective', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'SOCI 3301 Research Methods in Social Sci', 'credit': '3'},
      {'course': 'SOCI - Advanced SOCI Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'SOCI 4310 Social Inequality', 'credit': '3'},
      {'course': 'SOCI - Advanced SOCI Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'SOCI 4380 Senior Proseminar', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'}
    ],
    'Criminal Justice (BSCJ)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 1314 College Algebra', 'credit': '3'},
      {'course': 'CRIJ 1301 Intro to Criminal Justice', 'credit': '3'},
      {'course': 'CRIJ 1306 Courts&Criminal Procedure', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Field of Study Lower Level CRIJ Elective', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'CRIJ 2313 Correctional Systems&Practice', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'CRIJ 2328 Police Systems&Practices', 'credit': '3'},
      {'course': 'CRIJ 2329 Fundamentals of Criminal Law', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'SOCI 3336 Criminology', 'credit': '3'},
      {'course': 'CRIJ - Adv CRIJ Elective', 'credit': '3'},
      {'course': 'Adv Soc/Behavioral Science', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '3'},
      {'course': 'Field of Study Lower Level CRIJ Elective', 'credit': '3'},
      {'course': 'CRIJ - Adv CRIJ Elective', 'credit': '3'},
      {'course': 'CRIJ - Research Methods', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Foreign Lang/Study Abroad', 'credit': '3'},
      {'course': 'CRIJ 4325 Statistics in Criminal Justice', 'credit': '3'},
      {'course': 'CRIJ - Adv CRIJ Elective', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'Adv General Elective', 'credit': '2'},
      {'course': 'Adv Soc/Behavioral Science', 'credit': '3'},
      {'course': 'CRIJ 4321 Senior Pro-Seminar-WIN', 'credit': '3'},
      {'course': 'Adv Minor/General Elective', 'credit': '3'},
      {'course': 'CRIJ - Adv CRIJ Elective', 'credit': '3'},
      {'course': 'Adv Soc/Behavioral Science', 'credit': '3'}
    ],
    'Elementary Education and Teaching with a Bilingual Emphasis (BS)': [
      {'course': 'EDCI 1102 Intro to Teaching Profession', 'credit': '1'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'MATH 1314 College Algebra', 'credit': '3'},
      {'course': 'BIOL 1370 Survey of Life Science', 'credit': '3'},
      {'course': 'BIOL 1170 Survey of Life Science Lab', 'credit': '1'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'EDCI 2224 Cultural Foundations of Ed', 'credit': '2'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'PHYS 1370 Survey of Physical Science', 'credit': '3'},
      {'course': 'PHYS 1170 Survey of Physical Science Lab', 'credit': '1'},
      {'course': 'PSYC 2314 Lifespan Growth&Development', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'EPSC 1370 Survey of Earth Science', 'credit': '3'},
      {'course': 'EPSC 1170 Survey of Earth Science Lab', 'credit': '1'},
      {'course': 'MATH 1350 Fundamentals of Mathematics I', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'EDCI 3200 Survey of Content Know & Exper', 'credit': '2'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'MATH 1351 Fundamentals of Mathematics II', 'credit': '3'},
      {'course': 'ENGL 3361 Multicultural Children\'s Lit', 'credit': '3'},
      {'course': 'SPAN 2350 Intro to the Hispanic World', 'credit': '3'},
      {'course': 'EDRD 3309 Fdn. & Strat. Teach Lit EC-12', 'credit': '3'},
      {'course': 'KINE 3207 Hlth&Phys Ed for Elem Sch', 'credit': '2'},
      {'course': 'EDCI 3301 Assessment for Instruc Design', 'credit': '3'},
      {'course': 'EDEL 3362 Lang & Lit for Young Child', 'credit': '3'},
      {'course': 'EDEL 3374 Social Studies Prin for EC-6', 'credit': '3'},
      {'course': 'EDEL 3384 Science Prin for EC-Grade 6', 'credit': '3'},
      {'course': 'EDEL 3394 Math Prin for EC-Grade 6', 'credit': '3'},
      {'course': 'EDBE 3310 Foundations of Bilingual Edu', 'credit': '3'},
      {'course': 'EDBE 3325 Theories of 2nd Lang Learning', 'credit': '3'},
      {'course': 'EDBE 3335 Lang Arts Prin in Bil Settings', 'credit': '3'},
      {'course': 'EDRD 3303 Teaching Reading&Lang Arts', 'credit': '3'},
      {'course': 'SPAN 3303 Spanish Language for Bil Teach', 'credit': '3'},
      {'course': 'EDCI 3315 Impl Eff Inst Strat Div Lrnrs', 'credit': '3'},
      {'course': 'EDCI 4310 Engaging Learners', 'credit': '3'},
      {'course': 'EDRD 4311 Classrm Diag&Rem of Rdg Diff', 'credit': '3'},
      {'course': 'SPAN 3305 Spanish Academic Writing', 'credit': '3'},
      {'course': 'SPAN 3310 Intro to Literature in Spanish', 'credit': '3'},
      {'course': 'EDCI 4693 Clinical Teaching', 'credit': '6'},
      {'course': 'EDSE 4350 Inc Pract Ch&Yth W/Disablts', 'credit': '3'}
    ],
    'Elementary Education and Teaching with an Early Learning Emphasis (BS)': [
      {'course': 'EDCI 1102 Intro to Teaching Profession', 'credit': '1'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'MATH 1314 College Algebra', 'credit': '3'},
      {'course': 'BIOL 1370 Survey of Life Science', 'credit': '3'},
      {'course': 'BIOL 1170 Survey of Life Science Lab', 'credit': '1'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'EDCI 2224 Cultural Foundations of Ed', 'credit': '2'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'PHYS 1370 Survey of Physical Science', 'credit': '3'},
      {'course': 'PHYS 1170 Survey of Physical Science Lab', 'credit': '1'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'ARTS 3100 Art and Children', 'credit': '1'},
      {'course': 'EPSC 1370 Survey of Earth Science', 'credit': '3'},
      {'course': 'EPSC 1170 Survey of Earth Science Lab', 'credit': '1'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 1350 Fundamentals of Mathematics I', 'credit': '3'},
      {'course': 'MUSI 3100 Music and Children', 'credit': '1'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'THAR 3100 Theatre and Children', 'credit': '1'},
      {
        'course': 'EDCI 3200 Survey of Content Knowledge & Experience',
        'credit': '2'
      },
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'MATH 1351 Fundamentals of Mathematics II', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {
        'course': 'EDCI 3301 Assessment for Instructional Design',
        'credit': '3'
      },
      {'course': 'EDCI 3302 Teaching English Language Learners', 'credit': '3'},
      {
        'course': 'EDEL 3362 Language & Literature for Young Children',
        'credit': '3'
      },
      {'course': 'EDRD 3303 Teaching Reading & Language Arts', 'credit': '3'},
      {
        'course': 'ENGL 3361 Multicultural Children\'s Literature',
        'credit': '3'
      },
      {'course': 'EDEL 3384 Science Principles for EC-Grade 6', 'credit': '3'},
      {'course': 'EDEL 3394 Math Principles for EC-Grade 6', 'credit': '3'},
      {
        'course': 'EDRD 3309 Foundations & Strategies to Teach Lit EC-12',
        'credit': '3'
      },
      {
        'course': 'EDYC 3350 Home, School, & Community Relations',
        'credit': '3'
      },
      {
        'course': 'EDYC 3366 Curriculum Foundations for Young Children',
        'credit': '3'
      },
      {
        'course': 'KINE 3207 Health & Physical Education for Elementary School',
        'credit': '2'
      },
      {
        'course':
            'EDCI 3315 Implementing Effective Instructional Strategies for Diverse Learners',
        'credit': '3'
      },
      {'course': 'EDCI 4310 Engaging Learners', 'credit': '3'},
      {'course': 'EDEL 3374 Social Studies Principles for EC-6', 'credit': '3'},
      {
        'course':
            'EDRD 4311 Classroom Diagnosis & Remediation of Reading Difficulties',
        'credit': '3'
      },
      {'course': 'EDSE 3310 High Incidence Disabilities', 'credit': '3'},
      {'course': 'EDYC 4325 Trends & Issues in Early Learning', 'credit': '3'},
      {'course': 'EDCI 4693 Clinical Teaching', 'credit': '6'},
      {
        'course':
            'EDSE 4350 Inclusive Practices for Children & Youth with Disabilities',
        'credit': '3'
      }
    ],
    'Elementary Education and Teaching with a Special Education Emphasis (BS)':
        [
      {'course': 'EDCI 1102 Intro to Teaching Profession', 'credit': '1'},
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'MATH 1314 College Algebra', 'credit': '3'},
      {'course': 'BIOL 1370 Survey of Life Science', 'credit': '3'},
      {'course': 'BIOL 1170 Survey of Life Science Lab', 'credit': '1'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'EDCI 2224 Cultural Foundations of Education', 'credit': '2'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'PHYS 1370 Survey of Physical Science', 'credit': '3'},
      {'course': 'PHYS 1170 Survey of Physical Science Lab', 'credit': '1'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'EPSC 1370 Survey of Earth Science', 'credit': '3'},
      {'course': 'EPSC 1170 Survey of Earth Science Lab', 'credit': '1'},
      {'course': 'MATH 1350 Fundamentals of Mathematics I', 'credit': '3'},
      {
        'course': 'EDCI 3200 Survey of Content Knowledge & Experience',
        'credit': '2'
      },
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'MATH 1351 Fundamentals of Mathematics II', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {
        'course': 'ENGL 3361 Multicultural Children\'s Literature',
        'credit': '3'
      },
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {
        'course': 'EDCI 3301 Assessment for Instructional Design',
        'credit': '3'
      },
      {
        'course': 'EDEL 3362 Language & Literature for Young Children',
        'credit': '3'
      },
      {'course': 'EDEL 3384 Science Principles for EC-Grade 6', 'credit': '3'},
      {'course': 'EDEL 3394 Math Principles for EC-Grade 6', 'credit': '3'},
      {'course': 'EDEL 3374 Social Studies Principles for EC-6', 'credit': '3'},
      {'course': 'EDCI 3302 Teaching English Language Learners', 'credit': '3'},
      {'course': 'EDSE 3315 Low Incidence Disabilities', 'credit': '3'},
      {
        'course': 'EDSE 3320 Measurement & Evaluation for Special Education',
        'credit': '3'
      },
      {
        'course':
            'EDRD 4311 Classroom Diagnosis & Remediation of Reading Difficulties',
        'credit': '3'
      },
      {'course': 'EDRD 3303 Teaching Reading & Language Arts', 'credit': '3'},
      {
        'course':
            'EDCI 3315 Implementing Effective Instructional Strategies for Diverse Learners',
        'credit': '3'
      },
      {'course': 'EDCI 4310 Engaging Learners', 'credit': '3'},
      {'course': 'EDSE 4330 Special Education Law & Procedures', 'credit': '3'},
      {
        'course': 'EDSE 4360 Teaching Children with Challenging Behaviors',
        'credit': '3'
      },
      {'course': 'EDSE 3310 High Incidence Disabilities', 'credit': '3'},
      {'course': 'EDCI 4693 Clinical Teaching', 'credit': '6'},
      {
        'course':
            'EDSE 4350 Inclusive Practices for Children & Youth with Disabilities',
        'credit': '3'
      }
    ],
    'Communication Disorders (BS)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'BIOL 2301 Anatomy & Physiology I', 'credit': '3'},
      {'course': 'BIOL 2101 Anatomy & Physiology I Lab', 'credit': '1'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'Mathematics Core Course', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'Life and Physical Science', 'credit': '3'},
      {'course': 'Life and Physical Science Lab', 'credit': '1'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'PSYC 2301 Intro to Psychology', 'credit': '3'},
      {
        'course':
            'CHEM 1311 General Chemistry I or PHYS 1370 Survey of Physical Science',
        'credit': '3'
      },
      {
        'course':
            'CHEM 1111 General Chemistry I-Lab or PHYS 1170 Survey of Physical Science Lab',
        'credit': '1'
      },
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'PSYC 2317 Basic Stats for Psychology', 'credit': '3'},
      {'course': 'PSYC 2117 Basic Stats for Psychology Lab', 'credit': '1'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {
        'course': 'CSDO 3305 Introduction to Communication Disorders',
        'credit': '3'
      },
      {
        'course':
            'CSDO 3321 Anatomy & Physiology of Speech and Hearing Mechanism',
        'credit': '3'
      },
      {'course': 'CSDO 3325 Phonetics I', 'credit': '3'},
      {'course': 'CSDO 3331 Speech and Hearing Science', 'credit': '3'},
      {'course': 'CSDO 3333 Normal Language Acquisition', 'credit': '3'},
      {
        'course': 'CSDO 3314 Neuroanatomy in Communication Disorders',
        'credit': '3'
      },
      {'course': 'CSDO 3322 Clinical Observation Practicum', 'credit': '3'},
      {
        'course': 'CSDO 3335 Language & Literature Disorders in Children',
        'credit': '3'
      },
      {'course': 'CSDO 3336 Speech Sound Disorders', 'credit': '3'},
      {'course': 'CSDO 3413 Introduction to Audiology', 'credit': '4'},
      {'course': 'CSDO 4318 Advanced Audiology', 'credit': '3'},
      {
        'course':
            'CSDO 4320 Diagnosis & Evaluation in Speech-Language Pathology',
        'credit': '3'
      },
      {'course': 'CSDO 4330 Voice & Resonance Disorders', 'credit': '3'},
      {'course': 'CSDO 4399 Topics in Communication Disorders', 'credit': '3'},
      {
        'course': 'CSDO 4426 Clinical Practicum in Communication Disorders',
        'credit': '4'
      },
      {
        'course':
            'CSDO 4300 Multicultural-Linguistic Trends in Communication Disorders',
        'credit': '3'
      },
      {
        'course':
            'CSDO 4322 Introduction to Research in Communication Sciences & Disorders',
        'credit': '3'
      },
      {
        'course': 'CSDO 4326 Neurogenic Speech-Language Disorders',
        'credit': '3'
      },
      {
        'course': 'CSDO 4337 Foundations of Aural Rehabilitation',
        'credit': '3'
      },
      {
        'course':
            'CSDO 4438 Advanced Clinical Practicum in Communication Disorders',
        'credit': '4'
      }
    ],
    'Kinesiology with Concentration in Exercise Science (BS)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'BIOL 2301 Anatomy & Physiology I', 'credit': '3'},
      {'course': 'BIOL 2101 Anatomy & Physiology I Lab', 'credit': '1'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'BIOL 2302 Anatomy & Physiology II', 'credit': '3'},
      {'course': 'BIOL 2102 Anatomy & Physiology II Lab', 'credit': '1'},
      {'course': 'KINE 1111 Weight Training & Conditioning', 'credit': '1'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'KINE 1101 Aerobic Activities', 'credit': '1'},
      {'course': 'KINE 2301 Foundations of Fitness & Sports', 'credit': '3'},
      {'course': 'KINE 2312 Anatomical Kinesiology', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'KINE 2300 Physical Fitness', 'credit': '3'},
      {
        'course': 'KINE 2303 Care & Prevention of Athletic Injuries',
        'credit': '3'
      },
      {'course': 'KINE 2322 Pathophysiology Allied Health', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'KINE 3311 Physiology of Exercise', 'credit': '3'},
      {
        'course': 'KINE 3316 Psychological Aspects of Sport & Exercise',
        'credit': '3'
      },
      {'course': 'KINE 3318 Fundamentals of Biomechanics', 'credit': '3'},
      {'course': 'KINE 4315 Sport & Adapted Physical Activity', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'KINE 3312 Principles of Health Promotion', 'credit': '3'},
      {'course': 'KINE 3314 Tests and Evaluation', 'credit': '3'},
      {'course': 'KINE 3317 Nutrition for Exercise & Sports', 'credit': '3'},
      {'course': 'KINE 3319 Research Methods', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'KINE 4311 Advanced Exercise Physiology', 'credit': '3'},
      {'course': 'KINE 4317 Foundations of Sports Management', 'credit': '3'},
      {'course': 'KINE 4318 Exercise Prescription', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {
        'course': 'KINE 4316 Principles of Motor Learning & Control',
        'credit': '3'
      },
      {'course': 'KINE 4320 Special Topics in Kinesiology', 'credit': '3'},
      {
        'course': 'KINE 4336 Psychology of Sport Injury & Rehabilitation',
        'credit': '3'
      },
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'}
    ],
    'Kinesiology with Concentration in Health & Fitness (BS)': [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'BIOL 2301 Anatomy & Physiology I', 'credit': '3'},
      {'course': 'BIOL 2101 Anatomy & Physiology I-Lab', 'credit': '1'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'BIOL 2302 Anatomy & Physiology II', 'credit': '3'},
      {'course': 'BIOL 2102 Anatomy & Physiology II-Lab', 'credit': '1'},
      {'course': 'KINE 1111 Weight Training & Conditioning', 'credit': '1'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'KINE 1101 Aerobic Activities', 'credit': '1'},
      {'course': 'KINE 2301 Foundations of Fitness & Sports', 'credit': '3'},
      {'course': 'KINE 2312 Anatomical Kinesiology', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'KINE 2300 Physical Fitness', 'credit': '3'},
      {
        'course': 'KINE 2303 Care & Prevention of Athletic Injuries',
        'credit': '3'
      },
      {'course': 'KINE 2322 Pathophysiology Allied Health', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'KINE 3312 Principles of Health Promotion', 'credit': '3'},
      {'course': 'KINE 3313 Essentials of Personal Training', 'credit': '3'},
      {
        'course': 'KINE 3316 Psychological Aspects of Sport & Exercise',
        'credit': '3'
      },
      {'course': 'KINE 3318 Fundamentals of Biomechanics', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {'course': 'KINE 3311 Physiology of Exercise', 'credit': '3'},
      {'course': 'KINE 3314 Tests and Evaluation', 'credit': '3'},
      {
        'course': 'KINE 3315 Scientific Principles of Strength & Conditioning',
        'credit': '3'
      },
      {'course': 'KINE 3317 Nutrition for Exercise & Sports', 'credit': '3'},
      {'course': 'Minor/General Elective', 'credit': '3'},
      {
        'course': 'KINE 4312 Advanced Care & Prevention of Athletic Injuries',
        'credit': '3'
      },
      {'course': 'KINE 4317 Foundations of Sports Management', 'credit': '3'},
      {'course': 'KINE 4318 Exercise Prescription', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {
        'course': 'KINE 4313 Therapeutic Modalities for Athletic Trainers',
        'credit': '3'
      },
      {'course': 'KINE 4319 Practicum in Kinesiology', 'credit': '3'},
      {
        'course': 'KINE 4336 Psychology of Sport Injury & Rehabilitation',
        'credit': '3'
      },
      {'course': 'Advanced Minor/General Elective', 'credit': '3'},
      {'course': 'Advanced Minor/General Elective', 'credit': '3'}
    ],
    "Nursing (BSN)": [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'BIOL 2301 Anatomy & Physiology I', 'credit': '3'},
      {'course': 'BIOL 2101 Anatomy & Physiology I-Lab', 'credit': '1'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'MATH Core Course', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'BIOL 2302 Anatomy & Physiology II', 'credit': '3'},
      {'course': 'BIOL 2102 Anatomy & Physiology II-Lab', 'credit': '1'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'CHEM Chemistry', 'credit': '4'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'PSYC 2301 Intro to Psychology', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'BIOL Microbiology', 'credit': '4'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'NURS 2320 Nutrition', 'credit': '3'},
      {'course': 'NURS 2321 Pathophysiology', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'NURS 3200 Strategies for Success', 'credit': '2'},
      {'course': 'NURS 3310 Pharmacology', 'credit': '3'},
      {
        'course': 'NURS 3311 Cultural Determinants of Health Behavior-WIN',
        'credit': '3'
      },
      {'course': 'NURS 3410 Health Assessment', 'credit': '4'},
      {'course': 'NURS 3613 Basic Nursing', 'credit': '6'},
      {
        'course': 'NURS 3412 Psychiatric & Mental Health Nursing',
        'credit': '4'
      },
      {'course': 'NURS 3614 Adult Health Nursing I', 'credit': '6'},
      {'course': 'NURS 4310 Nursing Research-WIN', 'credit': '3'},
      {
        'course': 'NURS 3411 Childbearing & Women\'s Health Nursing',
        'credit': '4'
      },
      {'course': 'NURS 4410 Child Health Nursing', 'credit': '4'},
      {'course': 'NURS 4614 Adult Health Nursing II', 'credit': '6'},
      {'course': 'NURS 4312 Senior Nursing Seminar', 'credit': '3'},
      {'course': 'NURS 4411 Community Nursing', 'credit': '4'},
      {'course': 'NURS 4513 Professional Nursing Role', 'credit': '5'}
    ],
    "Public Health": [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {
        'course':
            'BIOL 2301 or BIOL 1306 Anatomy & Physiology I or Principles of Biology I',
        'credit': '3'
      },
      {
        'course':
            'BIOL 2101 or BIOL 1106 Anatomy & Physiology I-Lab or Principles of Biology I-Lab',
        'credit': '1'
      },
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'MATH Core Course', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {
        'course':
            'BIOL 2302 or BIOL 1311 Anatomy & Physiology II or Principles of Biology II',
        'credit': '3'
      },
      {
        'course':
            'BIOL 2102 or BIOL 1111 Anatomy & Physiology II-Lab or Principles of Biology II-Lab',
        'credit': '1'
      },
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'Social & Behavioral Science', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'COMM General Elective', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'PHLT 2320 Nutrition', 'credit': '3'},
      {'course': 'PSYC or SOCI Elective', 'credit': '3'},
      {'course': 'General Elective(s)', 'credit': '4'},
      {'course': 'PHLT 3301 Introduction to Public Health', 'credit': '3'},
      {
        'course': 'PHLT 3302 Writing for Public Health Professions',
        'credit': '3'
      },
      {'course': 'PHLT 3304 Public Health Systems', 'credit': '3'},
      {'course': 'PHLT 3312 Global Health-WIN', 'credit': '3'},
      {'course': 'PHLT 3364 Biostatistics for Public Health', 'credit': '3'},
      {
        'course': 'PHLT 3306 Emergency Management in Public Health',
        'credit': '3'
      },
      {'course': 'PHLT 3308 Research Methods in Public Health', 'credit': '3'},
      {
        'course': 'PHLT 3310 Environmental & Occupational Health',
        'credit': '3'
      },
      {
        'course': 'PHLT 3311 Cultural Determinants of Health Behavior-WIN',
        'credit': '3'
      },
      {'course': 'PHLT 4322 Vulnerable Populations\' Health', 'credit': '3'},
      {'course': 'PHLT 4213 Applied Research Project I', 'credit': '2'},
      {'course': 'PHLT 4318 Public Health Policy & Advocacy', 'credit': '3'},
      {'course': 'PHLT 4415 Community Immersion', 'credit': '4'},
      {
        'course': 'PHLT 4416 Principles of Public Health Education & Promotion',
        'credit': '4'
      },
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'PHLT 4214 Applied Research Project II', 'credit': '2'},
      {'course': 'PHLT 4303 Epidemiology', 'credit': '3'},
      {'course': 'PHLT 4420 Public Health Internship', 'credit': '4'},
      {'course': 'Advanced General Elective', 'credit': '3'},
      {'course': 'Advanced General Elective', 'credit': '3'}
    ],
    "Kinesiology with a concentration in Physical Education with EC-12 Certification (BS)":
        [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'BIOL 2301 Anatomy & Physiology I', 'credit': '3'},
      {'course': 'BIOL 2101 Anatomy & Physiology I-Lab', 'credit': '1'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'BIOL 2302 Anatomy & Physiology II', 'credit': '3'},
      {'course': 'BIOL 2102 Anatomy & Physiology II-Lab', 'credit': '1'},
      {'course': 'EDCI 1102 Intro to Teaching Profession', 'credit': '1'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'KINE 1101 Aerobic Activities', 'credit': '1'},
      {'course': 'KINE 1111 Weight Training & Conditioning', 'credit': '1'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'EDCI 2224 Cultural Foundations of Education', 'credit': '2'},
      {'course': 'KINE 2225 First Aid', 'credit': '2'},
      {'course': 'KINE 2300 Physical Fitness', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'Language, Philosophy and Culture', 'credit': '3'},
      {
        'course': 'EDCI 3200 Survey of Content Knowledge & Experience',
        'credit': '2'
      },
      {'course': 'KINE 2224 Team and Individual Sports', 'credit': '2'},
      {'course': 'KINE 2301 Foundations of Fitness & Sports', 'credit': '3'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {
        'course': 'EDCI 3301 Assessment for Instructional Design',
        'credit': '3'
      },
      {'course': 'KINE 3301 Coaching', 'credit': '3'},
      {'course': 'KINE 3311 Physiology of Exercise', 'credit': '3'},
      {
        'course': 'KINE 3316 Psychological Aspects of Sport & Exercise',
        'credit': '3'
      },
      {'course': 'KINE 3318 Fundamentals of Biomechanics', 'credit': '3'},
      {'course': 'EDCI 3302 Teaching English Language Learners', 'credit': '3'},
      {
        'course': 'KINE 3305 Teaching Physical Education in Elementary Schools',
        'credit': '3'
      },
      {'course': 'KINE 3312 Principles of Health Promotion-WIN', 'credit': '3'},
      {'course': 'KINE 3314 Tests and Evaluation', 'credit': '3'},
      {'course': 'KINE 3317 Nutrition for Exercise & Sports', 'credit': '3'},
      {
        'course':
            'EDCI 3315 Implementing Effective Instructional Strategies for Diverse Learners',
        'credit': '3'
      },
      {'course': 'EDCI 4310 Engaging Learners', 'credit': '3'},
      {
        'course':
            'EDSE 4350 Inclusive Practices for Children & Youth with Disabilities',
        'credit': '3'
      },
      {
        'course': 'KINE 3310 Teaching Physical Education in Secondary Schools',
        'credit': '3'
      },
      {'course': 'KINE 4315 Sport & Adapted Physical Activity', 'credit': '3'},
      {'course': 'EDCI 4693 Clinical Teaching', 'credit': '6'},
      {
        'course': 'KINE 4316 Principles of Motor Learning & Control',
        'credit': '3'
      },
      {'course': 'KINE 4317 Foundations of Sports Management', 'credit': '3'},
      {'course': 'KINE 4320 Special Topics in Kinesiology', 'credit': '3'}
    ],
    "Kinesiology with a Concentration in Pre-Physical/Occupational Therapy (BS)":
        [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'BIOL 1306 Principles of Biology I', 'credit': '3'},
      {'course': 'BIOL 1106 Principles of Biology I-Lab', 'credit': '1'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'MATH 1342 Introductory Statistics', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'BIOL 1371 Human Biology', 'credit': '3'},
      {'course': 'BIOL 1171 Human Biology-Lab', 'credit': '1'},
      {'course': 'KINE 1101 Aerobic Activities', 'credit': '1'},
      {'course': 'KINE 1111 Weight Training & Conditioning', 'credit': '1'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'CHEM 1311 General Chemistry I', 'credit': '3'},
      {'course': 'CHEM 1111 General Chemistry I-Lab', 'credit': '1'},
      {'course': 'KINE 2300 Physical Fitness', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'PSYC 2301 Intro to Psychology', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'MATH 1316 Plane Trigonometry', 'credit': '3'},
      {'course': 'CHEM 1412 General Chemistry II', 'credit': '4'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'PSYC 2314 Lifespan Growth & Development', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'PHYS 1301 General Physics I', 'credit': '3'},
      {'course': 'PHYS 1101 General Physics I Lab', 'credit': '1'},
      {'course': 'BIOL 3403 Human Anatomy', 'credit': '4'},
      {'course': 'KINE 3311 Physiology of Exercise', 'credit': '3'},
      {'course': 'KINE 3314 Tests and Evaluation', 'credit': '3'},
      {'course': 'PHYS 1302 General Physics II', 'credit': '3'},
      {'course': 'PHYS 1102 General Physics II Lab', 'credit': '1'},
      {'course': 'BIOL 3405 Human Physiology', 'credit': '4'},
      {'course': 'KINE 3312 Principles of Health Promotion-WIN', 'credit': '3'},
      {'course': 'KINE 3317 Nutrition for Exercise & Sports', 'credit': '3'},
      {
        'course': 'KINE 3316 Psychological Aspects of Sport & Exercise',
        'credit': '3'
      },
      {'course': 'KINE 3318 Fundamentals of Biomechanics', 'credit': '3'},
      {'course': 'KINE 4318 Exercise Prescription', 'credit': '3'},
      {'course': 'Advanced General Elective (3000-4000)', 'credit': '3'},
      {'course': 'Advanced General Elective (3000-4000)', 'credit': '3'},
      {
        'course': 'KINE 3315 Scientific Principles of Strength & Conditioning',
        'credit': '3'
      },
      {'course': 'KINE 4319 Practicum in Kinesiology', 'credit': '3'},
      {
        'course': 'KINE 4336 Psychology of Sport Injury & Rehabilitation WIN',
        'credit': '3'
      },
      {'course': 'Advanced General Elective (3000-4000)', 'credit': '3'},
      {'course': 'Advanced General Elective (3000-4000)', 'credit': '3'}
    ],
    "Multidisciplinary Studies (BA)": [
      {'course': 'ENGL 1301 English Composition I', 'credit': '3'},
      {'course': 'HIST 1301 The US to 1877', 'credit': '3'},
      {'course': 'Mathematics Core Course', 'credit': '3'},
      {'course': 'UNIV 1201 Learn a Global Context I', 'credit': '2'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'ENGL 1302 English Composition II', 'credit': '3'},
      {'course': 'HIST 1302 The US Since 1877', 'credit': '3'},
      {'course': 'PSCI 2305 American National Government', 'credit': '3'},
      {'course': 'UNIV 1302 Signature Course', 'credit': '3'},
      {'course': 'General Elective', 'credit': '2'},
      {'course': 'PSCI 2306 American State Government', 'credit': '3'},
      {'course': 'Creative Arts', 'credit': '3'},
      {'course': 'Language, Philosophy & Culture', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Concentration I', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'Life & Physical Science', 'credit': '3'},
      {'course': 'Life & Physical Science Lab', 'credit': '1'},
      {'course': 'Social/Behavioral Science', 'credit': '3'},
      {'course': 'Concentration II', 'credit': '3'},
      {'course': 'Concentration III', 'credit': '3'},
      {'course': 'Advance Concentration I', 'credit': '3'},
      {'course': 'Advance Concentration II', 'credit': '3'},
      {'course': 'Advance Concentration III', 'credit': '3'},
      {'course': 'Advance COMM Course', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'Advance Concentration I', 'credit': '3'},
      {'course': 'Advance Concentration II', 'credit': '3'},
      {'course': 'Advance Concentration III', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {
        'course': 'UNIV 3320 Community Engagement & Agents of Change',
        'credit': '3'
      },
      {'course': 'Advance Concentration I', 'credit': '3'},
      {'course': 'Advance Concentration II', 'credit': '3'},
      {'course': 'Advance Concentration III', 'credit': '3'},
      {'course': 'General Elective', 'credit': '3'},
      {'course': 'International Studies Elective', 'credit': '3'},
      {'course': 'UNIV 4390 Capstone Experience-WIN', 'credit': '3'}
    ],
  };

  final Set<String> _takenCourses = {};
  int _totalCredits = 0;

  @override
  void initState() {
    super.initState();
    _loadTakenCourses();
  }

  Future<void> _loadTakenCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCourses =
        prefs.getStringList('${widget.selectedMajor}_courses') ?? [];
    setState(() {
      _takenCourses.addAll(savedCourses);
      _calculateTotalCredits();
    });
  }

  Future<void> _saveTakenCourses() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        '${widget.selectedMajor}_courses', _takenCourses.toList());
  }

  void _calculateTotalCredits() {
    final courses = _majorsCourses[widget.selectedMajor] ?? [];
    _totalCredits = courses
        .where((course) => _takenCourses.contains(course['course']))
        .map((course) => int.tryParse(course['credit']!) ?? 0)
        .reduce((a, b) => a + b);
  }

  void _toggleCourse(String courseName) {
    setState(() {
      if (_takenCourses.contains(courseName)) {
        _takenCourses.remove(courseName);
      } else {
        _takenCourses.add(courseName);
      }
      _calculateTotalCredits();
      _saveTakenCourses();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              '$courseName has been ${_takenCourses.contains(courseName) ? 'added' : 'removed'}')),
    );
  }

  void _clearSelections() {
    setState(() {
      _takenCourses.clear();
      _totalCredits = 0;
    });
    _saveTakenCourses();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All selections cleared')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courses = _majorsCourses[widget.selectedMajor] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF500000),
        title: Text('${widget.selectedMajor} Class Input'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearSelections,
            tooltip: 'Clear All Selections',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Credits: $_totalCredits',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: courses.map((course) {
                  final isSelected = _takenCourses.contains(course['course']);
                  return ListTile(
                    title: Text(
                        '${course['course']} (${course['credit']} credits)'),
                    trailing: IconButton(
                      icon: Icon(
                        isSelected
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: isSelected ? Colors.green : Colors.grey,
                      ),
                      onPressed: () => _toggleCourse(course['course']!),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FallScreen extends StatefulWidget {
  final String major;

  FallScreen({required this.major, required List completedCourses});

  @override
  _FallScreenState createState() => _FallScreenState();
}

class _FallScreenState extends State<FallScreen> {
  Color maroonColor = Color(0xFF61162D); // Maroon color

  List<String> userEnteredCourses = []; // List to store user-entered courses
  bool isSubmitted = false;

  TextEditingController courseController = TextEditingController();

  // Define the predefined times for courses
  List<String> _courseTimes = [
    "8:30 A.M. MWF",
    "9:25 A.M. TTR",
    "10:20 A.M. MWF",
    "11:45 A.M. MWF",
    "1:00 P.M. TTR",
    "7:25 P.M TTR",
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedSchedule();
  }

  // Load saved schedule from SharedPreferences
  Future<void> _loadSavedSchedule() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedSchedule = prefs.getString('fallCourses');
    if (savedSchedule != null) {
      setState(() {
        userEnteredCourses = List<String>.from(json.decode(savedSchedule));
        isSubmitted = true;
      });
    }
  }

  // Save the schedule to SharedPreferences
  Future<void> _saveScheduleToAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String scheduleJson = json.encode(userEnteredCourses);
    await prefs.setString('fallCourses', scheduleJson);
    print("Saved schedule: $scheduleJson for major: ${widget.major}");
  }

  // Add a course with predefined times
  void _addCourse() {
    if (courseController.text.isNotEmpty && userEnteredCourses.length < 5) {
      setState(() {
        String courseName = courseController.text;
        String courseTime =
            _courseTimes[userEnteredCourses.length % _courseTimes.length];

        // Combine the course name and time
        userEnteredCourses.add('$courseName - $courseTime');
        courseController.clear();
      });
    }
  }

  // Edit a course
  void _editCourse(int index) {
    courseController.text = userEnteredCourses[
        index]; // Set the course text in the controller for editing
    setState(() {
      userEnteredCourses.removeAt(
          index); // Remove the course from the list to re-add it after editing
    });
  }

  // Remove a course
  void _removeCourse(int index) {
    setState(() {
      userEnteredCourses.removeAt(index);
    });
  }

  // Submit the courses
  void _submitCourses() async {
    await _saveScheduleToAccount();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fall courses saved successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.major} Fall Semester Classes"),
        backgroundColor: maroonColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Instruction Text
            const Text(
              "Enter your courses for the Fall semester (max 5 courses):",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Input Field for Course Name
            TextField(
              controller: courseController,
              decoration: InputDecoration(
                labelText: "Course Name",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Add Course Button
            ElevatedButton(
              onPressed: _addCourse,
              style: ElevatedButton.styleFrom(
                backgroundColor: maroonColor,
              ),
              child: const Text(
                "Add Course",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            // Display Added Courses
            if (userEnteredCourses.isNotEmpty) ...[
              const Text(
                'Fall Courses:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: userEnteredCourses.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: Text(
                          userEnteredCourses[index],
                          style: const TextStyle(fontSize: 14),
                        ),
                        leading: const Icon(Icons.check_circle),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Edit Button
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editCourse(index),
                            ),
                            // Remove Button
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeCourse(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Submit Classes Button
            ElevatedButton(
              onPressed: userEnteredCourses.isNotEmpty ? _submitCourses : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: maroonColor,
              ),
              child: const Text(
                "Submit Classes",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    courseController.dispose();
    super.dispose();
  }
}

class SharedPreferences {
  static getInstance() {}

  String? getString(String s) {
    return null;
  }

  setString(String s, String organizationsJson) {}

  getStringList(String s) {}

  setStringList(String s, List<String> springCourses) {}
}

class SpringScreen extends StatefulWidget {
  final String major;

  const SpringScreen(
      {Key? key, required this.major, required List completedCourses})
      : super(key: key);

  @override
  _SpringScreenState createState() => _SpringScreenState();
}

class _SpringScreenState extends State<SpringScreen> {
  final TextEditingController _courseController = TextEditingController();
  List<String> _springCourses = []; // List to store added Spring courses

  // Define the predefined times for courses
  List<String> _courseTimes = [
    "8:30 A.M. MWF", // For the first course added
    "9:25 A.M. TTR",
    "10:20 A.M. MWF",
    "11:45 A.M. MWF",
    "1:00 P.M. TTR",
    "7:25 P.M TTR",
  ];

  @override
  void initState() {
    super.initState();
    _loadSpringCourses(); // Load saved Spring courses on initialization
  }

  Future<void> _loadSpringCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _springCourses = prefs.getStringList('springCourses') ?? [];
    });
  }

  Future<void> _saveSpringCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('springCourses', _springCourses);
  }

  void _addCourse() {
    if (_courseController.text.isNotEmpty) {
      setState(() {
        // Check if the courseTimes list has enough times for new courses
        String courseName = _courseController.text;
        String courseTime =
            _courseTimes[_springCourses.length % _courseTimes.length];

        // Combine the course name and time
        _springCourses.add('$courseName - $courseTime');
        _courseController.clear();
      });
    }
  }

  void _editCourse(int index) {
    // Set the course text in the controller for editing
    _courseController.text = _springCourses[index];
    // Remove the course from the list to re-add it after editing
    setState(() {
      _springCourses.removeAt(index);
    });
  }

  void _removeCourse(int index) {
    setState(() {
      _springCourses.removeAt(index);
    });
  }

  void _submitCourses() async {
    await _saveSpringCourses();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Spring courses saved successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF500000), // Maroon color
        title: const Text(
          'Spring Schedule',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Field to Add Courses
            TextField(
              controller: _courseController,
              decoration: InputDecoration(
                labelText: 'Enter Course Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Add Course Button
            ElevatedButton(
              onPressed: _addCourse,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF500000), // Maroon color
              ),
              child: const Text(
                'Add Course',
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            // Display Added Courses
            if (_springCourses.isNotEmpty) ...[
              const Text(
                'Spring Courses:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _springCourses.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: Text(
                          _springCourses[index],
                          style: const TextStyle(fontSize: 14),
                        ),
                        leading: const Icon(Icons.check_circle),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Edit Button
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editCourse(index),
                            ),
                            // Remove Button
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeCourse(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            const SizedBox(height: 20),

            // Submit Classes Button
            ElevatedButton(
              onPressed: _submitCourses,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF500000), // Maroon color
              ),
              child: const Text(
                'Submit Classes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _courseController.dispose();
    super.dispose();
  }
}
