#!/bin/bash
echo "Enter Your Template Name: "

read template_name

echo "Enter Your Name: "

read project_name

npm create vite@latest ${template_name} -- --template react

npm i react-router-dom

cd ${template_name}

npm install -D tailwindcss postcss autoprefixer

npx tailwindcss init -p

cd ./public

mkdir images icons

cd ../

cat <<EOT > index.html

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="images/icon-logo.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${project_name}</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>

EOT

npm install flowbite flowbite-react

cat <<EOT > tailwind.config.js
module.exports = {

    plugins: [
        require('flowbite/plugin')
    ],
    content: [
        // ...
        'node_modules/flowbite-react/**/*.{js,jsx,ts,tsx}'
    ]

}
EOT

rm -rf $(pwd)/public/vite.svg

cd ./src

rm $(pwd)/App.css
rm $(pwd)/App.jsx

cat <<EOT > index.css

@tailwind base;
@tailwind components;
@tailwind utilities;

EOT

rm -rf $(pwd)/assets

mkdir pages components routes utils

cd ./pages

touch HomePage.jsx

cat  <<EOT > HomePage.jsx


import React, { Fragment } from 'react';

const HomePage = () => {
  return (
    <Fragment>
      Starter Template for ${template_name}
    </Fragment>
  );
}

export default HomePage;

EOT

cd ../

cd ./routes

touch routes.jsx

cat <<EOT > routes.jsx
import React from 'react';
import HomePage from './pages/HomePage.jsx'

export const PAGES = [
  {
    name : "Home Page",
    path : "/home",
    component : <HomePage />
  }
]

EOT

cd ../

cat <<EOT > main.jsx
import React from 'react'
import ReactDOM from 'react-dom/client'
import index from './index.css';
import { BrowserRouter } from 'react-router-dom';
import HomePage from './pages/Home/HomePage';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <BrowserRouter>
      <HomePage />
    </BrowserRouter>
  </React.StrictMode>
)
EOT