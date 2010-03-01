# language: zh-CN
功能: just so so

  场景大纲: 测试category
    假如有一个博客
    而且数据库中所有分类为<b_global>
    而且这个博客所拥有的分类为<b_related>
    当用户输入下面的<字符串>
    那么这个博客之后所拥有的分类为<a_related>
    而且提交后数据库中所有分类为<a_global>

    例子:
      | b_related       | b_global        | 字符串           | a_related       | a_global             |
      |                 |                 | rails           | rails           | rails                |
      | rails           | rails           | ruby rails lord | ruby rails lord | ruby rails lord      |
      | ruby rails lord | ruby rails lord | ruby            | ruby            | ruby rails lord      |
      | ruby            | ruby rails lord | rails ruby cool | ruby rails cool | ruby rails lord cool |





  
