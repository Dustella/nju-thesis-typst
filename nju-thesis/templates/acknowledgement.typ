// 致谢页
#import "../utils/style.typ": 字号, 字体

#let acknowledgement(
  // documentclass 传入参数
  anonymous: false,
  twoside: false,
  // 其他参数
  title: "致谢",
  outlined: true,
  body,
) = {
  if (not anonymous) {
    pagebreak(weak: true, to: if twoside { "odd" })
    [
      #align(center)[
      #set text(font:字体.黑体, size:字号.四号)
      #heading(level: 1, numbering: none, outlined: outlined, title) <no-auto-pagebreak>
      ]

      #set text(font:字体.楷体, size:字号.小四)
      #body
    ]
  }
}