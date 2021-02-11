# CSF SaaS Capstone Project - Cafeteria Management System

This cafeteria management project was built as the capstone project for CSF SaaS.

## Tech stack used:

- Ruby (2.6.3)
- Rails (6.1.1)
- ERB for rendering templates.
- PostgreSQL

## Project Summary

A multi-user portal with owner, customer and billing clerk accounts, that allows creating menus and placing orders.

## All Features

- ### Customer can:

  - Sign-up to the application, sign-in and sign-out.
  - Can see a menu of items that can be purchased.
  - Add multiple quantities of selected items to their cart.
  - Increase and decrease item quantity and remove items form cart.
  - Place and order for items added to cart.
  - See all of their orders and the delivery status for each order.

- ### Owner can:

  - Create a new menu.
    - Add items to this menu.
    - Set a menu as active menu. (only the active menu is visible to the customer)
  - View, add, delete and edit menu items.
  - Place an order for walk-in customer.
  - See incoming orders and mark them as delivered.
  - See a list of users and their roles.
  - Create accounts for billing clerks.
  - See order reports filtered by date.

- ### Billing clerk can:
  - Place an order for walk-in customer.
  - See incoming orders and mark them as delivered.

## Live Link

The project is live on Heroku [here](https://apurva-cafeteria-manager.herokuapp.com/).

Demo account credentials:

- Owner Account
  - ID: cafeowner@gmail.com
  - Password: 123456
- Customer Account
  - ID: michael@theoffice.com
  - Password: 123456
- Billing Clerk Account:
  - ID: clerk1@gmail.com
  - Password: 123456

## Screenshots (Check live link for updated features)

![Landing Page](./screenshots/landingpage.png)
![Owner Order Page](./screenshots/orders-owner.png)
![Owner Menu Page](./screenshots/menus-owner.png)
![Owner Menu Items Page](./screenshots/menu-items-owner.png)
![Owner Edit Menu Items Page](./screenshots/edit-menu-owner.png)
![Owner Edit Menu Page](./screenshots/edit-menu-item-owner.png)
![Owner Users List](./screenshots/users.png)
![Customer Menu Page](./screenshots/menu-customer.png)
![Customer Order Page](./screenshots/orders-customer.png)
![Customer Cart Page](./screenshots/cart-customer.png)
![Owner Report Page](./screenshots/reports-owner.png)
