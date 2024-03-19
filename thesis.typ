#import "nju-thesis/template.typ": documentclass, tablex, fig, tlt, indent
#import "nju-thesis/utils/style.typ": 字号, 字体
#import "nju-thesis/utils/indent.typ": fake-par
#import "nju-thesis/utils/invisible-heading.typ": invisible-heading


// 双面模式，会加入空白页，便于打印
#let twoside = false
// #let twoside = true

#let (
  doc, preface, mainmatter, mainmatter-end, appendix,
  fonts-display-page, cover, decl-page, abstract, abstract-en, outline-page, list-of-figures, list-of-tables, notation, acknowledgement,
) = documentclass(
  // type: "bachelor",  // "bachelor" | "master" | "doctor" | "postdoc", 文档类型，默认为本科生 bachelor
  // degree: "academic",  // "academic" | "professional", 学位类型，默认为学术型 academic
  // anonymous: true,  // 盲审模式
  twoside: twoside,  // 双面模式，会加入空白页，便于打印
  // 可自定义字体，先英文字体后中文字体，应传入「宋体」、「黑体」、「楷体」、「仿宋」、「等宽」
  // fonts: (楷体: ("Times New Roman", "FZKai-Z03S")),
  info: (
    title: "基于 Typst 的 NUIST 本科学位论文",
    title-en: "My Title in English",
    grade: "20XX",
    student-id: "1234567890",
    author: "张三",
    author-en: "Ming Xing",
    department: "计算机院",
    department-en: "School of Computing",
    major: "计算机科学与技术",
    major-en: "Computer Science",
    supervisor: ("李四", "教授"),
    supervisor-en: "Professor My Supervisor",
    // supervisor-ii: ("王五", "副教授"),
    // supervisor-ii-en: "Professor My Supervisor",
    submit-date: "二零二三 年 五 月 六 日",
    super-title: "本科生毕业设计"
  ),
)

// 文稿设置
#show: doc

// 字体展示测试页
// #fonts-display-page()

// 封面页
#cover()

// 前言
#show: preface
// 目录
#outline-page()

// 中文摘要
#abstract(
  keywords: ("我", "就是", "测试用", "关键词")
)[  欢迎阅读 Typst 的中文文档！Typst 是为科学写作而诞生的基于标记的排版系统。 它被设计之初就是作为一种替代品，用于替代像 LaTeX 这样的高级工具，又或者是像 Word 和 Google Docs 这样的简单工具。 我们对 Typst 的目标是构建一个功能强大的排版工具，并且让用户可以愉快地使用它。
]

// 英文摘要
#abstract-en(
  keywords: ("Dummy", "Keywords", "Here", "It Is")
)[
  English abstract
]
#pagebreak()




// 正文
#show: mainmatter


= 基本功能

== 脚注

我们可以添加一个脚注。#footnote[脚注内容]

== 列表

=== 无序列表

- 无序列表项一
- 无序列表项二
  - 无序子列表项一
  - 无序子列表项二

=== 有序列表

+ 有序列表项一
+ 有序列表项二
  + 有序子列表项一
  + 有序子列表项二

=== 术语列表

/ 术语一: 术语解释
/ 术语二: 术语解释

== 图表

引用@tbl:timing，引用@tbl:timing-tlt，以及@fig:nju-logo。引用图表时，表格和图片分别需要加上 `tbl:`和`fig:` 前缀才能正常显示编号。以及这里使用 `fig` 函数替代原生 `figure` 函数以支持将 `tablex` 作为表格来识别。

#fig(
  tablex(
    align: center + horizon,
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [常规表],
) <timing1>

#fig(
  tlt(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [三线表],
) <timing-tlt1>

#align(center, (stack(dir: ltr)[
  #fig(
    tablex(
      align: center + horizon,
      columns: 4,
      [t], [1], [2], [3],
      [y], [0.3s], [0.4s], [0.8s],
    ),
    caption: [堆叠常规表],
  ) <timing>
][
  #h(50pt)
][
  #fig(
    tlt(
      columns: 4,
      [t], [1], [2], [3],
      [y], [0.3s], [0.4s], [0.8s],
    ),
    caption: [堆叠三线表],
  ) <timing-tlt>
]))

#fig(
  image("nju-thesis/assets/vi/nju-emblem.svg", width: 20%),
  caption: [图片测试],
) <nju-logo>


== 数学公式

可以像 Markdown 一样写行内公式 $x + y$，以及带编号的行间公式：

$ phi.alt := (1 + sqrt(5)) / 2 $ <ratio>

引用数学公式需要加上 `eqt:` 前缀，则由@eqt:ratio，我们有：

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

#indent 图表和公式后的段落要用 `#indent` 手动缩进。同时，我们也可以通过 `<->` 标签来标识该行间公式不需要编号

$ y = integral_1^2 x^2 dif x $ <->

而后续数学公式仍然能正常编号。

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

== 参考文献

可以像这样引用参考文献：@wang2010guide 和 @kopka2004guide。

== 代码块

代码块支持语法高亮。引用时需要加上 `lst:` @lst:code

#fig(
```py
def add(x, y):
  return x + y
```, caption:[代码块]) <code>


= 正文

== 正文子标题

=== 正文子子标题

正文内容


// 手动分页
#if (twoside) {
  pagebreak() + " "
}


#v(字号.五号)

// 参考文献
#[

#set text(font: 字体.黑体, size: 字号.四号)
#set par(first-line-indent: 0em)

#heading(numbering: none, level: 1)[参考文献]
#fake-par

#set text(font: 字体.宋体, size: 字号.小五)
#bibliography(("bibs/ex01.bib", "bibs/ex02.bib"),
  style: "gb-7714-2005-numeric",
  title: none
)
]


// 致谢
#acknowledgement[
  感谢 NJU-LUG，感谢 NJUThesis LaTeX 模板。
]

// 手动分页
#if (twoside) {
  pagebreak() + " "
}

// 正文结束标志，不可缺少
#mainmatter-end()

// 附录
#show: appendix

= 附录

== 附录子标题

=== 附录子子标题

附录内容，这里也可以加入图片，例如@fig:appendix-img。

#fig(
  image("nju-thesis/assets/vi/nju-emblem.svg", width: 20%),
  caption: [图片测试],
) <appendix-img>
