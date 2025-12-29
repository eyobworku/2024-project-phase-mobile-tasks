eCommerce App - Clean Architecture

🏛 Architecture Overview
This project follows Clean Architecture principles to promote separation of concerns and maintainability.

Project Folders

core: Contains shared components, entities, and universal error-handling logic.

features/product: The primary module containing the eCommerce logic.

test: Housing all unit and widget tests for the application.

🔄 Data Flow

The application logic moves through distinct layers to ensure the UI remains decoupled from the data source:

Presentation Layer: Flutter widgets trigger actions via BLoC or Providers.

Domain Layer: Use cases like ViewAllProductsUsecase or CreateProductUsecase execute specific business rules.

Data Layer: The ProductRepository implementation uses ProductModel to convert raw JSON data from APIs into usable Entities.

🧪 Testing Strategy

Unit Tests: We implement comprehensive unit tests for every model (e.g., ProductModel) to verify JSON serialization.

Error Handling: The data layer is designed to catch and return specific failures, ensuring the app remains stable during network issues.
