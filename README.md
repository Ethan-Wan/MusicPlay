# @dragon/eslint-config

杭州趣链科技有限公司--创新业务部&供应链金融部 ESlint 配置规范

- [ESlint 规则](#@dragon/eslint-config-eslint)
    - [base](#@dragon/eslint-config-eslint-base) 
    - [typescript](#@dragon/eslint-config-ts) 
    - [react](#@dragon/eslint-config-react) 
    - [vue](#@dragon/eslint-config-vue) 
- [prettier 配置](#@dragon/eslint-config-prettier)
- [VSCode ESlint 支持](#@dragon/eslint-config-vscode)
- 具体规则说明 （TODO）

<a name="@dragon/eslint-config-eslint"></a>
## eslint 规则

<a name="@dragon/eslint-config-eslint-base"></a>
### base（基础配置）

<a name="@dragon/eslint-config-eslint-base-install"></a>
##### 安装

> 之后只列出npm安装方式，yarn同理

- 工具 `eslint`
- eslint 解析器 `babel-eslint`
- 相关插件 `eslint-plugin-import`
- prettier `prettier`、`eslint-config-prettier`
- 当前规则库 `@dragon/eslint-config`

```bash
# npm
npm install eslint babel-eslint eslint-plugin-import prettier eslint-config-prettier @dragon/eslint-config  --save-dev

# yarn
yarn add eslint babel-eslint eslint-plugin-import prettier eslint-config-prettier @dragon/eslint-config --dev
```

##### 配置

在项目根目录下新建`.eslintrc.js`文件并复制如下内容

``` json
  module.exports = {
    extends: [
      "@dragon"
    ]
  }
```

### typescript

##### 安装

- 工具 `eslint`
- eslint 解析器 `@typescript-eslint/parser`
- 相关插件 `eslint-plugin-import`
- prettier `prettier`、`eslint-config-prettier`
- 当前规则库 `@dragon/eslint-config`
- 额外的规则库 `@typescript-eslint`

```bash
npm install eslint @typescript-eslint/parser eslint-plugin-import prettier eslint-config-prettier @dragon/eslint-config @typescript-eslint  --save-dev
```

##### 配置

> 值得注意的是，该配置和基础规则配置相同，也就是意味着：
> 1. 如果项目是一个普通的 `typescript` 项目，则直接安装本节中相应的依赖即可
> 2. 如果项目是基于`vue`的`typescript`项目，那么下文中的 base 规则依赖指的就是本节的相关依赖
> 3. `react`同理

在`.eslintrc.js`文件中添加以下内容

``` json
{
  extends: [
    "@dragon"
  ]
}

```

<a name="@dragon/eslint-config-eslint-react"></a>
### react

##### 安装

在[ base 规则依赖安装](#@dragon/eslint-config-eslint-base-install)之后，需要额外安装`eslint-plugin-jsx-a11y`、`eslint-plugin-react` `eslint-plugin-react-hooks`三个插件

```bash
npm install eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-react-hooks --save-dev
```

##### 配置

在`.eslintrc.js`文件中添加以下内容

``` json
{
  extends: [
    "@dragon/eslint-config/react"
  ]
}

```

<a name="@dragon/eslint-config-eslint-vue"></a>
### vue

##### 安装

在[base规则依赖安装](#@dragon/eslint-config-eslint-base-install)之后，需要额外安装`eslint-plugin-vue`三个插件

```bash
npm install eslint-plugin-vue --save-dev
```

##### 配置

在`.eslintrc.js`文件中添加以下内容

``` json
{
  extends: [
    "@dragon/eslint-config/vue"
  ]
}

```

<a name="@dragon/eslint-config-prettier"></a>
## 配合 prettier

@dragon/eslint-config 中关闭了所有与样式相关的规则，因此需要自行配置`prettier`，在项目根目录下创建 `.prettier.js` 文件并复制如下内容

```javascript
module.exports = {
    printWidth: 100, // 一行最多 100 字符
    tabWidth: 2, // 使用 2 个空格缩进
    useTabs: false, // 不使用tab缩进符，而使用空格
    semi: false, // 行尾不需要有分号
    singleQuote: true, // 字符串使用单引号
    quoteProps: 'as-needed', // 对象的 key 仅在必要时用引号
    jsxSingleQuote: false, // jsx 不使用单引号，而使用双引号
    trailingComma: 'none', // 末尾不需要逗号
    bracketSpacing: true, // 大括号内的首尾需要空格
    arrowParens: 'always', // 箭头函数，只有一个参数的时候，也需要括号
    // 每个文件格式化的范围是文件的全部内容
    rangeStart: 0,
    rangeEnd: Infinity,
    proseWrap: 'preserve', // 使用默认的折行标准
    htmlWhitespaceSensitivity: 'css', // 根据显示样式决定 html 要不要折行
    endOfLine: 'lf' // 换行符使用 lf
};
```

由于在 @dragon/eslint-config 中关闭了默认的样式规则，因此即使安装了 VSCode ESLint 插件之后，在样式上的匹配与否也并不会在编辑器上显示，这里有两种方式去修改样式问题：

1.**当`commit`文件的时候执行`pretty-quick`去修复样式问题**

安装
```bash
npm install pretty-quick husky --dev-save
```

在`package.json`中添加如下代码
```json
{ 
  "husky": { 
    "hooks": { 
        "pre-commit": "pretty-quick --staged" 
    } 
  } 
}
```

2.**通过 VSCode 中 ESlint 插件提示并`autoFixOnSave`**

安装
```bash
npm install eslint-plugin-prettier husky --dev-save
```

在 ESLint 配置文件`.eslintrc.js`文件中添加 `prettier` 规则

```javascript
{
  plugins: ["prettier"],
  rules: {
    "prettier/prettier": "error"
  }
}
```

<a name="@dragon/eslint-config-vscode"></a>

## VSCode ESlint 支持

> 若没有安装ESlint插件，请先在【VSCode > Extensions > ESlint】中安装插件

在 VSCode 中，默认的 ESLint 无法识别`.ts`、`.tsx`、 `.vue`文件。可以前往 【Code > 首选项 > 配置】
```json
{
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "vue",
    "typescript",
    "typescriptreact"
  ]
}
```

同时需要启动对`.ts`、`.tsx`、 `.vue`文件的 autoFix 支持
```json
{
  "eslint.autoFixOnSave": true,
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    {
      "language": "vue",
      "autoFix": true
    },
    {
      "language": "typescript",
      "autoFix": true
    },
    {
      "language": "typescriptreact",
      "autoFix": true
    }
  ]
}
```

## 贡献

若在开发过程中对规则的约束力度或匹配规则有不同的意见可以积极提出您的建议，方式如下：

1. 在gitlab仓库中新建分支，将您认为合适的规则添加到相应的配置文件，并添加规则通过与失败时相应的代码，并提交`merge request`
2. 将需要添加或者删除的规则提交在`issue`中，由仓库管理者来统一维护
