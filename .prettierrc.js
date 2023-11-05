module.exports = {
  endOfLine: 'lf',
  printWidth: 120,
  tabWidth: 2,
  singleQuote: true,
  trailingComma: 'none',
  semi: true,
  quoteProps: 'as-needed',
  arrowParens: 'avoid',
  plugins: ['prettier-plugin-packagejson'],
  overrides: [
    {
      files: '*.ts',
      options: { parser: 'typescript' }
    }
  ]
};
