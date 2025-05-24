## Running in development mode

#### Dependencies:
[![Ruby](https://img.shields.io/badge/Ruby-3.3.7-red?logo=ruby&logoColor=white)](https://www.ruby-lang.org/)

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-17-blue?logo=postgresql&logoColor=white)](https://www.postgresql.org/)

[![Node.js](https://img.shields.io/badge/Node.js-20-green?logo=node.js&logoColor=white)](https://nodejs.org/)

Fill credentials in `.env` file as
```
VECTORS_APP_DATABASE_USERNAME = <your_postgres_username>
VECTORS_APP_DATABASE_PASSWORD = <your_postgres_password>
```

Install dependencies:
```bash
bundle install
npm install
```

Config database migrations:

```bash
rails db:create
rails db:migrate
rails db:seed
```

Run the project with:

```bash
foreman start -f Procfile.dev
```

[Our site](https://vectors-web.onrender.com) is deployed on [render.com](https://render.com)

[![GitHub Repo](https://img.shields.io/badge/GitHub-Visit-blue?logo=github)](https://github.com/spartanec22832/vectors_web)

[![License](https://img.shields.io/badge/License-MIT-blue)](https://mit-license.org/)
