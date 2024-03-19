#import "@preview/t4t:0.3.2": is
#import "../utils/custom-tablex.typ": gridx, colspanx
#import "../utils/datetime-display.typ": datetime-display
#import "../utils/style.typ": 字号, 字体

// 本科生封面
#let bachelor-cover(
  // documentclass 传入的参数
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  stoke-width: 0.5pt,
  min-title-lines: 2,
  info-inset: (x: 0pt, bottom: 1pt),
  info-key-width: 74pt,
  column-gutter: -8pt,
  row-gutter: 1pt,
  anonymous-info-keys: ("grade", "student-id", "author", "supervisor", "supervisor-ii"),
  bold-info-keys: ("title",),
  bold-level: "bold",
  datetime-display: datetime-display,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title: "基于 Typst 的南京信息工程大学学位论文",
    super-title: "本科生毕业论文(设计)",
    grade: "20XX",
    student-id: "1234567890",
    author: "张三",
    department: "某学院",
    major: "某专业",
    supervisor: ("李四", "教授"),
    submit-date: datetime.today(),
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if (is.str(info.title)) {
    info.title = info.title.split("\n")
  }
  // 2.2 根据 min-title-lines 填充标题
  info.title = info.title + range(min-title-lines - info.title.len()).map((it) => "　")
  // 2.3 处理提交日期
  if (is.type(datetime, info.submit-date)) {
    info.submit-date = datetime-display(info.submit-date)
  }

  // 3.  内置辅助函数
  let info-key(body, font: fonts.宋体) = {
    rect(
      width: 100%,
      inset: info-inset,
      stroke: none,
      text(font: font, size: 字号.三号, body),
    )
  }

  let info-value(key, body, font: fonts.宋体) = {
    set align(center)
    rect(
      width: 100%,
      inset: info-inset,
      stroke: (bottom: stoke-width + black),
      text(
        font: font,
        size: 字号.三号,
        weight: if (key in bold-info-keys) { bold-level } else { "regular" },
        bottom-edge: "descender",
        body,
      ),
    )
  }

  let info-long-value(key, body, font: fonts.宋体) = {
    colspanx(3,
      info-value(
        key,
        if (anonymous and (key in anonymous-info-keys)) {
          "██████████"
        } else {
          body
        },
        font: font,
      )

    )
  }

  let info-short-value(key, body) = {
    info-value(
      key,
      if (anonymous and (key in anonymous-info-keys)) {
        "█████"
      } else {
        body
      }
    )
  }
  

  // 4.  正式渲染
  
  pagebreak(weak: true, to: if twoside { "odd" })

  // 居中对齐
  set align(center)

  // 匿名化处理去掉封面标识
  v(33pt)


  // 将中文之间的空格间隙从 0.25 em 调整到 0.5 em
  image("../assets/vi/nuist-banner.svg", width: 10.38cm)
  
  text(size: 字号.一号, font: fonts.黑体, spacing: 200%, weight: "bold", 
    info.super-title
  )


    // 封面图标
    v(22pt)
    // 调整一下左边的间距
    pad(image("../assets/vi/nuist-logo.png", width: 2.5cm), left: 0.4cm)
  
    v(50pt)
  


  block(width: 400pt, gridx(
    columns: (info-key-width, 1fr, info-key-width, 1fr),
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    info-key("题     目", font:fonts.黑体), 
    info-long-value("title", info.title.at(0), font: fonts.黑体)
  ))

  v(30pt)

  block(width: 250pt, gridx(
    columns: (info-key-width, 1fr, info-key-width, 1fr),
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    info-key("学生姓名"),
    info-long-value("author", info.author),
    info-key("学　　号"),
    info-long-value("student-id", info.student-id),
    info-key("院　　系"),
    info-long-value("department", info.department),
    info-key("专　　业"),
    info-long-value("major", info.major),
    info-key("指导教师"),
    info-long-value("supervisor", info.supervisor.at(0)),
    // info-key("提交日期"),
    // info-long-value("submit-date", info.submit-date),
  ))

  v(70pt)

  text(size: 字号.三号, font: fonts.黑体, spacing: 200%, weight: "bold",
    info.submit-date
  )

}