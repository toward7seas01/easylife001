Factory.define :blog01, :class => "blog" do |b|
  b.title "Google超越可口可乐成为全球第二大最有价值品牌 "
  b.content " 巴别塔上的雇工 写道 \"Google在其不长的历史中又到达了一个里程碑，根据Brand Finance的分析报告，Google的品牌价值已经超越可口可乐、微软和IBM成为全球第二，仅次于沃尔玛。搜索巨人的品牌价值大约为361亿美元，高于可口可乐的348亿美元，仅次于沃尔玛的413亿美元品牌价值。2008年 Google的排名是世界第五，今年他们超越了 IBM，微软和惠普，同时也把 GE，汇丰银行，Vodafone 和丰田汽车踩在了脚下。\""
  b.association :user, :factory => :user01
end

Factory.define :blog02, :class => "blog" do |b|
  b.title "调查称互联网让人变聪明"
  b.content "2008年一期的《大西洋月刊》称，Google正让我们变蠢，因为沉迷于网络让人失去思考的能力。 但最新的一项调查发现，网络可以提升阅读及写作能力，让人变聪明。这项由北卡罗来纳大学与民调机构合作的调查，对将近九百名网友和专家进行线上问卷，超过四分之三的人相信，拜网络之赐，未来十年内，人会变得更聪明，多数人也认为网络可以提升阅读和写作能力。不过也有21%的受访者认为网络的坏处大过于好处，成天挂在网络上，有可能让人变笨。"
  b.association :user, :factory => :user01
end

Factory.define :blog03, :class => "blog" do |b|
  b.title "Google获准购买和销售电力 "
  b.content "美国联邦能源管制委员会（FERC）周四批准(PDF)Google可以以批发形式买卖电力。 Google在去年12月以一家全资子公司Google Energ的名义向FERC递交了买卖能源的申请。Google的一位发言人称，为满足包括数据中心在内的自身运作需求，这项申请将为电力采购提高灵活性。数据中心需要消耗大量电力，但Google获得授权也可能意味着购买和销售电力将成为Google的一项新业务。"
  b.association :user, :factory => :user02
end

