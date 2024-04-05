module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  safelist: [
    'alert-error',
    'alert-success',
    'alert-warning',
    // 他の動的に生成されるクラス名もここに追加
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
}
