// import 'dart:io';
// import 'dart:math';

// import 'package:path_provider/path_provider.dart';
// import 'package:suyu_simple/model/ChatMessage.dart';
// import 'package:suyu_simple/model/enum/MsgType.dart';

// class RandomUtil {
//   static final _random = new Random();
//   static const _chars_eng =
//       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//   static const _chars_zh =
//       '松暑雁鬼朴贝茄奶尽挺谁泳变瞧敞禽室疗派非项鸡葡蜂挤牛东蝴讲音哲拘保蓝邻便香梨骂惊播一愚羡向漆走禾粒斥雾章奇洋植铁咸肉嫩撤简甩睁移鲁放控婆狮迅俭慨读赖界凶常揭训烂跌蜘泪即疮赛岭这艘设红王桶巨磨妹驶兽原钳膜燥仍爪籍效转速立释引兼菜竞慢装等萍贱略败慰滋标怜吨添猾轨溜饰旅炼典投搏自利副真若困落培腹族洞葱弄裙山恳涨伍坏晋酷侍晓亿拿慧棉沟傲体细号嫂访尊升以赔隙页拆辩膏临缴斜窃毕栋稻始饥塑梅图收猫狠咬美掘脱射械乌稼除徐慎蚁厌抓榨弦块模江艳耍党圣匠攻驴泥意晌夏态光垄火于木米玩招事炭宏疫俊杀偷宴沿就拌洗科弓排适抖铺且屿遣据潮俘印禁歪乓年受鞭爬储衫叨捆论盗腿臭歌逝进回消闯末马竭嘴坝抵仗鸣评健萄值冰壶艺鹅伶皮池业机阻面又囊屯究级驰霞休渣猎斩停翅九悼瞎致蜻顷眼详露截剂罚榆伸币冬洁安芽最述砖馒望目方混入句盾均源辜皱么肝厅扩挨养活启贵认溪毁翠好率愈煤乡女堪拦叛妈力辈亭看湿炒汇捏赴齐益绘钉兰毫谷疾紧概治命刺盼刚高唉牵趟胳聪路权炎枪切节摆视免氧桂纵秀抚猛袄识豪谦帽膝特和青航让价蓬匹练慌驼竟察奉泊奴无联庸需膨棚锈叹呀情谊嗽魔矛齿哭征诊泰孕纪析扣遥授生厚糊扛尸姜倘泄店甘塞楼精刃捞览残待糖同虾殃款刑抛士蚂穗寺脑国胸膀椅殊累锡由劈型瓜核手匪定剥导骨挑薯唇虑顺疤永扬决裕漠南像僚栏辱川拖假爱眠话麦貌罐响屋软很纸技分睡协些姓备怠急碧各昼获葬吓蹈迟钩了世肿巴酸勺厨打扰桨疏园涝柴拨享售障筋皇问聋专术搞卫去婚鞠趋榴窜刀育子俯府犁少药烦雷狗巩堆瘦愿嚷啦偿姻扑馆绣裳轮明创踏煎络做卧牢依拉书赏版麻院叮叙污名也轰今艇塌尺霸吵雀字父脏祥撕崭钱库屡浪接求镇胖赞苹锯苏饱抹贞午石企寄空贤数叼增丛笛班浇夸乳瑞在陕爹代四税坛俩躺谅踪袜卖肚吗独至既谣探柱液确哨误借买凝歼段席含省忠触缝誓牙哀盟岔剃觉岂朵咱盒礼极腥插强盯允文社疑羽传台铃听玉逆寒旁林菠册畜惑丈何租叫蛋恭给靠密熊尝胡璃令躁妨惭姿持雹加计旗正制客能脊耗遮颂茎凭魄英螺蔑归贸炕醉竹驳通纤秆位早化干漂沸恼肃跪廊较榜箱树妥候击申梯务戴叉七映浊布筛搂宅讯静傻役肤垃锻演浅灯调朋逗已枕吞身帐诉冻绞斯岁度黄绕天仿秃严箩食追堂覆沈步危宰灿怀湾燕操缩够浸耐悦烛烘清其梦阳脉刷被堤嫌姥忆叔泛芬时宽估合励轧顿月深诞丁欣悬财顽龙逐棒况元挣斗撒罪贿涌领埋悲骡僻丽参居尼邪揪扭套蕉神抢臂星古冶硬言腰风醋者拥瓦斑件匙腾占悠现品舅审整崇稿薄冒渗师迷辛吃港锤辟海篇哥俗杯圾妇角私帖呜穿桃昆互柿珠换夕坊迈伐介纽筑娇葵刻朱掀寻';

//   ///from [min], inclusive, to [max], exclusive.
//   static int numberScope(int min, int max) => min + _random.nextInt(max - min);

//   static String getRandomString(int length) =>
//       String.fromCharCodes(Iterable.generate(length,
//           (_) => _chars_eng.codeUnitAt(_random.nextInt(_chars_eng.length))));
//   static String getRandomStrNoMoreThan(int length) {
//     return getRandomString(RandomUtil.numberScope(0, length));
//   }

//   // ignore: non_constant_identifier_names
//   static String getRandomString_zh(int length) =>
//       String.fromCharCodes(Iterable.generate(length,
//           (_) => _chars_zh.codeUnitAt(_random.nextInt(_chars_zh.length))));

//   // ignore: non_constant_identifier_names
//   static String getRandomStrNoMoreThan_zh(int length) {
//     return getRandomString_zh(RandomUtil.numberScope(1, length));
//   }

//   static ChatMessage getRandomMsg() {
//     return new ChatMessage(
//       content: RandomUtil.getRandomStrNoMoreThan_zh(25),
//       createID: "1001",
//       createTime: "2020-11-2 15:49:03",
//       type: MsgType.Text.index,
//       isSend: 1,
//       direct: RandomUtil.numberScope(0, 2),
//       createName: RandomUtil.getRandomStrNoMoreThan_zh(3),
//     );
//   }

//   static ChatMessage getRandomMsgPic() {
//     return new ChatMessage(
//       createID: "1001",
//       createTime: "2020-11-2 15:49:03",
//       type: MsgType.Pic.index,
//       isSend: 1,
//       path: "assets/images/girl.png",
//       direct: RandomUtil.numberScope(0, 2),
//       createName: RandomUtil.getRandomStrNoMoreThan_zh(3),
//     );
//   }

//   static ChatMessage getUserRandomMsg(String text, int from) {
//     return new ChatMessage(
//       content: text,
//       createID: "1001",
//       createTime: "2020-11-2 15:49:03",
//       type: MsgType.Text.index,
//       isSend: 1,
//       direct: from,
//       createName: RandomUtil.getRandomStrNoMoreThan_zh(3),
//     );
//   }

//   static Future<ChatMessage> getRandomMsgPicWithPic(File image) async {
//     // getting a directory path for saving
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String appDocPath = appDocDir.path;
//     int imgHash = image.hashCode;
//     String newImagePath = appDocPath + "/" + imgHash.toString() + ".jpg";
//     print("-----RandomUtils-----");
//     print(newImagePath);

//     // copy the file to a new path
//     await image.copy(newImagePath);
//     // ChatMessage c =

//     return new ChatMessage(
//       createID: "1001",
//       createTime: "2020-11-2 15:49:03",
//       type: MsgType.Pic.index,
//       isSend: 1,
//       path: newImagePath,
//       direct: 0,
//       createName: RandomUtil.getRandomStrNoMoreThan_zh(3),
//     );
//   }
// }
