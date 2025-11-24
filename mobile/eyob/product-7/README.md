# Flutter Ecommerce App - Task 7 Navigation

This project is a simple Ecommerce mobile application built with Flutter. It demonstrates **CRUD (Create, Read, Update, Delete)** functionality for products.

## Features

- **Product List:** View all available products on the Home Screen.
- **Product Details:** Click on a product to view detailed information.
- **Add & Edit:** Create new products or edit existing ones using a form.
- **Delete:** Remove products from the list.

## Technical Highlights

- **Named Routes:** Uses string-based identifiers (e.g., `/details`) for navigation instead of anonymous routes.
- **Data Passing:** seamless transfer of product objects between the Home, Details, and Add/Edit screens.
- **Custom Animations:** Implements a custom `SlideTransition` for smooth screen switching.
- **Navigation Events:** Handles back-button functionality and data return logic.

## Project Structure

- `lib/main.dart`: App entry point, route definitions, and animation logic.
- `lib/product_model.dart`: The data model class for Products.
- `lib/home_screen.dart`: Displays the list of products.
- `lib/add_edit_product_screen.dart`: The form for creating/updating products.
- `lib/details_screen.dart`: Read-only view of product details.

## How to Run

    flutter pub get

    flutter run
