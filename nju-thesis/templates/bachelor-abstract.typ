#import "@preview/t4t:0.3.2": is
#import "../utils/style.typ": 字号, 字体
#import "../utils/indent.typ": fake-par
#import "../utils/double-underline.typ": double-underline
#import "../utils/invisible-heading.typ": invisible-heading

// 本科生中文摘要页
#let bachelor-abstract(
  // documentclass 传入的参数
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  keywords: (),
  outline-title: "中文摘要",
  outlined: true,
  anonymous-info-keys: ("author", "supervisor", "supervisor-ii"),
  leading: 1.08em,
  spacing: 1.08em,
  body,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title: ("基于 Typst 的", "南京大学学位论文"),
    author: "张三",
    department: "某学院",
    major: "某专业",
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if (is.str(info.title)) {
    info.title = info.title.split("\n")
  }

  // 3.  内置辅助函数
  let info-value(key, body) = {
    if (not anonymous or (key not in anonymous-info-keys)) {
      body
    }
  }

  // 4.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })

  [
    #set text(font: fonts.楷体, size: 字号.小四)
    
    #set par(leading: leading, justify: true)
    #show par: set block(spacing: spacing)

    // 标记一个不可见的标题用于目录生成
    // #invisible-heading(level: 1, outlined: outlined, outline-title)


    // 标题
    #align(center)[
      #set text(size: 字号.三号, weight: "bold", font: fonts.黑体 )
      #info-value("title", (("",)+ info.title).sum())
      #v(字号.五号)
    ]
      
    // 作者
    #align(center)[
      #set text(size: 字号.四号, font: fonts.宋体)
      #info-value("author", info.author)
    ]

    // 学院
    #align(center)[
      #set text(size: 字号.小五, font: fonts.宋体)
      南京信息工程大学#info-value("department", info.department), 江苏 南京, 210044
    ]


    #[
      #set text(size: 字号.五号, font: fonts.黑体, weight: "bold")
      摘要 
      #set text(size: 字号.五号, font: fonts.楷体, weight: "regular")
      #body
    ]

    #[
      #set text(size: 字号.五号, font: fonts.黑体, weight: "bold")
    *关键词*：
      #set text(size: 字号.五号, font: fonts.楷体, weight: "regular")
    #(("",)+ keywords.intersperse("；")).sum()
    ]
  ]
}