cmake_minimum_required(VERSION 3.16)

project(Pharmacy VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Quick Sql)
find_package(Qt6 REQUIRED COMPONENTS Quick Sql Charts)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appPharmacy
    main.cpp
)

qt_add_qml_module(appPharmacy
    URI Pharmacy
    QML_FILES
        Main.qml
        QML_FILES Management.qml
        SOURCES authcontroller.h authcontroller.cpp
        SOURCES
        SOURCES
        SOURCES medicine.h
        SOURCES medicine.cpp
        SOURCES manufacturer.h
        SOURCES manufacturer.cpp
        SOURCES marketers.h
        SOURCES marketers.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appPharmacy PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appPharmacy
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appPharmacy
    PRIVATE Qt6::Quick Qt6::Sql Qt6::Charts
)

include(GNUInstallDirs)
install(TARGETS appPharmacy
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
