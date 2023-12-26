# HackerNewsApp2023

## Description
This project was developed as a technical challenge by Woven Corporation.
It features the ability to display a list of HackerNews articles,
as well as read these articles through an in-app browser. Additionally,
by switching tabs, users can view both new and popular articles.

## Getting Started
1. Make sure you have the Xcode version 15.0 or above installed on your computer
2. Download the HackerNewsApp2023 project from the repository
3. Open the project file in Xcode
4. Select schema for `HackerNewsApp2023`
5. Run the build!

## Usage
nothing to write?

## Architecture
HackerNewsApp2023 project is implemented using Model-View-ViewModel (MVVM) architecture pattern. (More about MVVM - https://learn.microsoft.com/en-us/dotnet/architecture/maui/mvvm)

- Model is responsible for the data and business logic
- View is responsible for the presentation layer. This components display the data and captures users input.
- ViewModel is responsible for transforming data from the Model in a way that the View can easily display it. ViewModel also listens for changes in the Model and reflects these changes in the View.  

## Structure
- "HackerNewsApp2023": This module belongs to the core section and primarily contains files and image resources for the View layer.
- "Domain": This module includes the foundational domain objects and business logic of the application. The business logic is defined as UseCases, categorized by their specific purposes.
- "Infra": This module houses the persistence layer processes. It adopts the Repository pattern, ensuring efficiency and ease of testing.
- "Utility": This module contains items intended for general use throughout the application.

## Running the tests
The HackerNewsApp2023 project is capable of performing tests using XCTest.
Not only can you execute tests for the entire application,
but since test targets are created for each module, it's also possible to conduct partial tests as needed.

## Deployment

## Dependency

## Design
The UI design of this project is based on the Human Interface Guidelines. (Human Interface Guidelines - https://developer.apple.com/design/human-interface-guidelines)
Additionally, the following video, which introduces the fundamental concepts of SwiftUI, was also used as a reference. (Design with SwiftUI - https://developer.apple.com/videos/play/wwdc2023/10115/)

## API
- We are using a REST API
- For HTTP networking we are using Codable (See APIClient file for more details!)
