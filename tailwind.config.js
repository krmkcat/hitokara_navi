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
        mytheme: {
          "primary": "#3F6C45",
          "secondary": "#50312F",
          "accent": "#CB0000",
          "neutral": "#fef9c3",
          "base-100": "#E4EA8C",
          "info": "#5eead4",
          "success": "#4ade80",
          "warning": "#fbbf24",
          "error": "#f87171",
        },
      },
    ],
  },
}
