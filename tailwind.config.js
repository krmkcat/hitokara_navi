module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],
  daisyui: {
    themes: [
      {
        lemonade: {
          ...require("daisyui/src/theming/themes")["lemonade"],
          "--rounded-btn": "9999px",
        },
      },
    ],
  },
  theme: {
    extend: {
      colors: {
        'line-green': '#06C755',
        'line-green-hover': '#05b34c',
        'line-green-active': '#048b3b',
      },
    },
  },
}
