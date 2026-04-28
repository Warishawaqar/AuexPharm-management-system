AUEXPHARM MANAGEMENT SYSTEM:
Project Overview:
Project Name: AuexPharm Management System
Lead Developer: Syeda Warisha Waqar
Development Stack: 
•	Back-end: C++ (Object-Oriented Programming)
•	Front-end: Qt Quick / QML
•	Data Persistence: File-based storage (CSV format)
•	IDE: Dev-C++ / Qt Creator
________________________________________
1.	System Architecture
The project follows a Controller-View pattern where the C++ classes manage data logic and the QML files handle the user interface.
A. Data Management (C++ Back-end)
The system uses three primary managers to handle business entities:
•	ProductManager: Manages medicine stock, categories, and pricing.
•	ManufacturerManager: Tracks production companies and their contact details.
•	MarketerManager: Oversees distributors, regional coverage, and licensing.
Key Technical Features:
•	Dynamic Memory: Used pointers-to-pointers (Medicine list) to manage data arrays efficiently.
•	Persistence: Implemented custom file Input and Output to read and write .txt files in a CSV-style format.
•	Search Logic: Linear search algorithms implemented to filter indices based on user input.
B. User Interface (QML Front-end)
The GUI is designed for professional use with a focus on scannability:
•	Sidebar Navigation: Uses a Repeater and StackLayout for seamless switching between modules.
•	Responsive Tables: Custom ListView delegates with alternating row colors for readability.
•	Dynamic Updates: Used Signals and Slots to ensure the UI refreshes instantly whenever data is added, edited, or deleted.
________________________________________
2.	Module Breakdown
Module	Data Fields Managed	Core Functionalities
Inventory	ID, Name, Category, Stock, Price	Add/Edit/Delete, Search, Stock Monitoring
Manufacturers	ID, Company, Location, Contact, Email	Vendor tracking, Contact management
Marketers	ID, Name, Region, License, Rating	Distribution tracking, Region-based filtering
________________________________________
3.	Key Implementation Challenges & Solutions
•	The "Diamond Problem" and OOP: In the class structure, we ensured clean inheritance and encapsulation to prevent data repitition
•	QML-C++ Integration: Solved by registering C++ objects as ContextProperties in main.cpp, allowing the GUI to "call" backend functions directly.
•	Data Consistency: Implemented a stripCR utility to handle different line-ending formats (Windows vs. Unix) during file parsing.
________________________________________
4.	Future Enhancements
1.	Database Integration: Transitioning from .txt files to SQLite for better handling of larger datasets.
2.	Sales Module: Adding a "Checkout" feature to automatically deduct stock from the xyz.txt file when a purchase is made.
3.	User Roles: Implementing different access levels for "Admin" and "Pharmacist."
________________________________________
6. Conclusion
The AuexPharm Management System successfully demonstrates the power of C++ for backend efficiency combined with the modern asthetics of QML. It provides a robust foundation for managing a pharmacy's core operations through organized data structurs and a user-friendly interface.
________________________________________

