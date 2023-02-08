// description: API代码
// author: WPBKJ
// date: 2023-02-07

// 快递公司代码
const Map<String, String> expressCode = {
  "中通快递": "zto",
  "申通快递": "sto",
  "圆通速递": "yto",
  "天天快递": "tiantian",
  "EMS快递": "ems",
  "韵达快递": "yunda",
  "优速快递": "yousu",
  "百世快运": "800best",
  "百世汇通快递": "huitong",
  "宅急送快递": "zhaijisong",
  "龙邦快递": "longbang",
  "苏宁快递": "suning",
  "国通快递": "guotong",
  "京东快递": "jingdong",
  "京东物流": "jd",
  "邮政平邮": "pingyou",
  "顺丰": "shunfeng"
};

const Map<String, String> codeExpress = {
  "zto": "中通快递",
  "sto": "申通快递",
  "yto": "圆通速递",
  "tiantian": "天天快递",
  "ems": "EMS快递",
  "yunda": "韵达快递",
  "yousu": "优速快递",
  "800best": "百世快运",
  "huitong": "百世汇通快递",
  "zhaijisong": "宅急送快递",
  "longbang": "龙邦快递",
  "suning": "苏宁快递",
  "guotong": "国通快递",
  "jingdong": "京东快递",
  "jd": "京东物流",
  "pingyou": "邮政平邮",
  "shunfeng": "顺丰"
};

// 快递状态代码（详细信息）
const Map<int, String> stateCode = {
  1: "正常",
  2: "派送中",
  3: "已签收",
  4: "退回",
  5: "其他问题",
};

// 快递状态代码（总状态）
const Map<String, String> statusCode = {
  "WAIT_ACCEPT": "待揽收",
  "ACCEPT": "已揽收",
  "TRANSPORT": "运输中",
  "DELIVERING": "派件中",
  "AGENT_SIGN": "代签收",
  "SIGN": "已签收",
  "FAILED": "快递异常"
};
