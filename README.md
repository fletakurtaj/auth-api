# 🔐 Auth API — JWT Authentication Service

A clean and modern Ruby on Rails authentication API, built for a backend engineering portfolio.  
Provides: secure signup, login, JWT authentication, protected routes, and production-style structure.

---

## 🚀 Features
- ✔️ User registration (Signup)
- ✔️ Secure login using JWT
- ✔️ Protected `/me` endpoint
- ✔️ Password hashing (bcrypt)
- ✔️ Centralized token authentication
- ✔️ Clean  responses
- ✔️ Lightweight Rails API-only structure
- ✔️ Ready for integration with frontend apps (React, Next.js, mobile)

---

## 🛠️ Tech Stack
- Ruby: 3.3.0  
- Rails: 7.1.x  
- Database: PostgreSQL  
- Auth: JWT  
- Password Hashing: bcrypt  
- Environment: WSL2 (Ubuntu)  

---

## 📌 API Endpoints

### ✅ POST /signup  
Creates a new user account.

Request

{
  "user": {
    "email": "test@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
}
Response



{
  "message": "Account created successfully",
  "user": {
    "id": 1,
    "email": "test@example.com"
  }
}
✅ POST /login
Authenticates user & returns a JWT token.

Request



{
  "email": "test@example.com",
  "password": "password123"
}
Response



{
  "token": "jwt.token.value",
  "user": {
    "id": 1,
    "email": "test@example.com"
  }
}
⭐ GET /me (Protected)
Returns the logged-in user.

Requires header:



Authorization: Bearer <token>
Response



{
  "user": {
    "id": 1,
    "email": "test@example.com"
  }
}
🔐 How Authentication Works (Human-friendly explanation)
1️⃣ Signup
Validates email format

Checks email uniqueness

Hashes password with bcrypt

Saves user to database

2️⃣ Login
User enters email + password

Server verifies them

If valid → creates a JWT token containing user_id

Client stores this token (frontend, mobile app, etc.)

3️⃣ Calling Protected Routes
Client sends:



Authorization: Bearer <jwt_token>
Server steps:

Extracts token

Decodes it using Rails secret_key_base

Reads user_id

Loads the correct user

Continues the request

If token is invalid → returns 401 Unauthorized
If missing → returns 401 Unauthorized
If user deleted → 404 Not Found

This is real production-grade authentication, identical to what modern SaaS APIs use.

📁 Folder Structure (Important Files)


app/
  controllers/
    auth_controller.rb    # signup, login, me
  controllers/concerns/
    authorization.rb      # token decoding, current_user
  models/
    user.rb               # bcrypt password hashing
config/
db/
🧪 Running the Project Locally
1️⃣ Clone the repo


git clone https://github.com/fletakurtaj/auth-api.git
cd auth-api
2️⃣ Install dependencies


bundle install
3️⃣ Set up database


rails db:create db:migrate
4️⃣ Start the server


rails server
API runs at:
👉 http://localhost:3000

🧩 Example Testing Commands
Signup


curl -X POST http://localhost:3000/signup \
  -H "Content-Type: application/" \
  -d '{"user":{"email":"test@example.com","password":"123456","password_confirmation":"123456"}}'
Login


curl -X POST http://localhost:3000/login \
  -H "Content-Type: application/" \
  -d '{"email":"test@example.com","password":"123456"}'
Access Protected Route


curl http://localhost:3000/me \
  -H "Authorization: Bearer <your_token_here>"
  
👤 Author
Fleta Kurtaj
Backend Engineer — Ruby on Rails
GitHub: https://github.com/fletakurtaj

yaml

