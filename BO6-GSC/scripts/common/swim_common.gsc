/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\swim_common.gsc
******************************************/

#using scripts\common\callbacks;
#using scripts\common\heartbeat;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace swim_common;

function initcommonswim(var_3775369203f49857, var_5dd94eede306043b, var_fcb2b6105dd4a97e, enterfunc, exitfunc, surfacefunc, descendfunc, playsoundfunc, visionsetfunc, drownfunc, var_c1feb60bb5e0b2d3, var_493157cd579bb69b) {
  setdvarifuninitialized(@ "hash_2a4f08bc79265550", 0);
  level.swim = spawnStruct();
  level.swim.var_3775369203f49857 = var_3775369203f49857;
  level.swim.var_5dd94eede306043b = var_5dd94eede306043b;
  level.swim.var_fcb2b6105dd4a97e = var_fcb2b6105dd4a97e;
  level.swim.enterfunc = enterfunc;
  level.swim.exitfunc = exitfunc;
  level.swim.surfacefunc = surfacefunc;
  level.swim.descendfunc = descendfunc;
  level.swim.playsoundfunc = playsoundfunc;
  level.swim.visionsetfunc = visionsetfunc;
  level.swim.drownfunc = drownfunc;
  level.swim.var_dd44b9ee2a91cdad = var_c1feb60bb5e0b2d3;
  level.swim.var_493157cd579bb69b = var_493157cd579bb69b;
  level.swim.sfx = function_278a208f55e8ec1b();
  function_a970905633e0a04();
}

function function_278a208f55e8ec1b() {
  sfx = spawnStruct();
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "\x95\xcd\x96\x04\x04", "\x1d5\x17"], "\x06m_\x89+\xc0\xc2\x96YyMH\xe0\xa0\xb7X>\xcaU\xef\x92\x15E9\x97FY\xf8");
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "\x95\xcd\x96\x04\x04", "\xb8\xa4h"], "\x8c\x93\xbdQ\xd5\xa2\xeb\x86\x84>\x96\x05Y\xaar\x89\x88\x9d\xa9\x10\xdf\x98\xb9\x9d\nh\xba\x95");
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "T4\xde\xcb\x16\x85", "\x1d5\x17"], "\"6N\xe01\x8b?\xb0j\xc3\x11\xb8\x17\x83F\x02-\x81aL\xf2\x02\xe4\xde\xe6\x9a\x18\x81>\xe1:?\\>\xed\x0e");
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "T4\xde\xcb\x16\x85", "\xb8\xa4h"], "mg[G}\x9bw-\xd6\xfa\xb9\xae'f\xb0l\xd2\xcd\xce\xeb\xb9\x83l\xeb\xe6\x1b\xdb\xee}\xd9\v7\x1cKsv");
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "\x83\xd1\xe7\xf1", "\x1d5\x17"], "\"6N\xe01\x8b?\xb0j\xc3\x11\xb8\x17\x83F\x02-\x81aL\xf2\x02\xe4\xde\xe6\x9a\x18\x81>\xe1:?\\>\xed\x0e");
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "\x83\xd1\xe7\xf1", "\xb8\xa4h"], "mg[G}\x9bw-\xd6\xfa\xb9\xae'f\xb0l\xd2\xcd\xce\xeb\xb9\x83l\xeb\xe6\x1b\xdb\xee}\xd9\v7\x1cKsv");
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "\x95\xcd\x96\x04\x04", "\x1d5\x17"], "$\x16\\\xc6\x91!sL\xb0=\x03\xb6\xde,\x01\xa0\xb5\x127\xff\xa2\xc8%\x1e8\xa7Xd\x8f\xa6");
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "\x95\xcd\x96\x04\x04", "\xb8\xa4h"], "$\xcd\xd7\x818M\x1dp\xd9\xbf\v\xe5\xb4\x95?O\a\x7f\x8f\xa2\x84A\xf8\x02\xc8\xb1\xb9{\x89\r");
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "T4\xde\xcb\x16\x85", "\x1d5\x17"], "^U\xde\xe8\xf4\xbf\x9f\xe8\x84\xf4\xf1&o\x98\xe7<\xfe\x81\x0fc\a2@\xd58\x1fV\xe0F\xbb\xcb\x15X\x91\x8d\xa8P\xfd");
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "T4\xde\xcb\x16\x85", "\xb8\xa4h"], "\xb5\xc8:a5\x12R\xd1Z\xdd\x8c\x95B\xa15r\x8e\xeeF\xa4\xe6\xac\xad/\x1fI\n8\xd7A\xe5\xb7\x0e\xa3\xd0\xcf#\xae");
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "\x83\xd1\xe7\xf1", "\x1d5\x17"], "^U\xde\xe8\xf4\xbf\x9f\xe8\x84\xf4\xf1&o\x98\xe7<\xfe\x81\x0fc\a2@\xd58\x1fV\xe0F\xbb\xcb\x15X\x91\x8d\xa8P\xfd");
  sfx buildaliasarray(["P\x96\xea", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "\x83\xd1\xe7\xf1", "\xb8\xa4h"], "\xb5\xc8:a5\x12R\xd1Z\xdd\x8c\x95B\xa15r\x8e\xeeF\xa4\xe6\xac\xad/\x1fI\n8\xd7A\xe5\xb7\x0e\xa3\xd0\xcf#\xae");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "\x95\xcd\x96\x04\x04", "\x1d5\x17"], "\x0eo\xd6\x11\x14\xb3|o\\\xde\xd0q!i\xb8.>\a\xa1\b\xaa;\xc4\x04V\xff\xbc");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "\x95\xcd\x96\x04\x04", "\xb8\xa4h"], "\xce\fKf>\x9f\xed<`\f\xe6F\xbb\x18\x89A\xb3\x85\xab\xb8\xda\x95\xa7\x880oi");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "T4\xde\xcb\x16\x85", "\x1d5\x17"], "0^}e\xf2\xbb\xed\xb9^<F\fL\xec\xc4\xd0\x04\x91\x18Lx\xb5\xfe\f\x0f\xe7_\xb3\xe4\\\xbe\x12\x8d\x94Y\xdf");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "T4\xde\xcb\x16\x85", "\xb8\xa4h"], "H\xe9m\xeb\xf6\xb1\xc9\"\xd3}\x1a\xab\xaa.D\x92\xferE0\x9f\xd4\x9c\x86\xe5\x15\xefE-u\xd5_\x1a\xf7t\x8a");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "\x83\xd1\xe7\xf1", "\x1d5\x17"], "0^}e\xf2\xbb\xed\xb9^<F\fL\xec\xc4\xd0\x04\x91\x18Lx\xb5\xfe\f\x0f\xe7_\xb3\xe4\\\xbe\x12\x8d\x94Y\xdf");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "\x83\xd1\xe7\xf1", "\xb8\xa4h"], "H\xe9m\xeb\xf6\xb1\xc9\"\xd3}\x1a\xab\xaa.D\x92\xferE0\x9f\xd4\x9c\x86\xe5\x15\xefE-u\xd5_\x1a\xf7t\x8a");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "\x95\xcd\x96\x04\x04", "\x1d5\x17"], "\xb1}*l\xa1g\xab\x1a\x86\xbf]\f4_\x0e\f\x81\xd7\xfb\xc2\xb8o<\xdePs\x126\x8a");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "\x95\xcd\x96\x04\x04", "\xb8\xa4h"], "\xdd\x13\x89N\b\f\xc7\x18\xb8A\xeeX\xdb\xf7+z\x9e7\xbf\xb9B(\x80\xb5\xfd\x95Fs\xed");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "T4\xde\xcb\x16\x85", "\x1d5\x17"], "\a\xd84\xb1TU\x1f{Ck\xd2\xc0~\xc9\x05\xdc\xa7\xa9\xa4\v\x1f\x1d\xee\xbd}Q:\xf5%\xb7\xe7\x8e\x04\x8a\\\xbeXh");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "T4\xde\xcb\x16\x85", "\xb8\xa4h"], "9\xac\x1f\x95_\x80\xaa\xa4\xb5\xd8X\x93\xc5_\xea8\xf9\xee\x12\x13\x95\x94\xc82\x02\x8b\x16\x13\xa5\x93i\xf9ti\xdf\xd2\x10\x9d");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "\x83\xd1\xe7\xf1", "\x1d5\x17"], "\a\xd84\xb1TU\x1f{Ck\xd2\xc0~\xc9\x05\xdc\xa7\xa9\xa4\v\x1f\x1d\xee\xbd}Q:\xf5%\xb7\xe7\x8e\x04\x8a\\\xbeXh");
  sfx buildaliasarray(["P\x96\xea", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "\x83\xd1\xe7\xf1", "\xb8\xa4h"], "9\xac\x1f\x95_\x80\xaa\xa4\xb5\xd8X\x93\xc5_\xea8\xf9\xee\x12\x13\x95\x94\xc82\x02\x8b\x16\x13\xa5\x93i\xf9ti\xdf\xd2\x10\x9d");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "\x95\xcd\x96\x04\x04", "\x1d5\x17"], "\x9a\xdd\xbc(\x88\xcc\x9d\xa7\xa1(\x1c\xb1\xa0\x84\x15\x88\x9b\x05\xb9\xa2\x8f\x14\xd8\x82\x1e!\xcc");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "\x95\xcd\x96\x04\x04", "\xb8\xa4h"], "\f\x1d\xe3\xdfd\x0e\x0e\xc8\xec\vE=\a\x81d\xcf\x92W/&\xb8\xbb\x85\x7f\xa1\xc10");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "T4\xde\xcb\x16\x85", "\x1d5\x17"], "\xf4\x126QS\x17`w\xfa\xcb\xcd\xc7\xdf\xfcm\x129\x05\xba\xb8\xef\xe8K\x94g\xa6\xf8\x91\xd0[N\xf9");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "T4\xde\xcb\x16\x85", "\xb8\xa4h"], "\r\xa0VW\xe8w \n\x18\x16\x86\xb3\x82t\x1e\x84\xe1s\x83#\xa4\xf4\t\xc5\xa3C\xe1<\xd3\x91'S");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "\x83\xd1\xe7\xf1", "\x1d5\x17"], "\xf4\x126QS\x17`w\xfa\xcb\xcd\xc7\xdf\xfcm\x129\x05\xba\xb8\xef\xe8K\x94g\xa6\xf8\x91\xd0[N\xf9");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x88\x9b\x86{", "\x83\xd1\xe7\xf1", "\xb8\xa4h"], "\r\xa0VW\xe8w \n\x18\x16\x86\xb3\x82t\x1e\x84\xe1s\x83#\xa4\xf4\t\xc5\xa3C\xe1<\xd3\x91'S");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "\x95\xcd\x96\x04\x04", "\x1d5\x17"], "\x9a\xdd\xbc(\x88\xcc\x9d\xa7\xa1(\x1c\xb1\xa0\x84\x15\x88\x9b\x05\xb9\xa2\x8f\x14\xd8\x82\x1e!\xcc");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "\x95\xcd\x96\x04\x04", "\xb8\xa4h"], "\f\x1d\xe3\xdfd\x0e\x0e\xc8\xec\vE=\a\x81d\xcf\x92W/&\xb8\xbb\x85\x7f\xa1\xc10");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "T4\xde\xcb\x16\x85", "\x1d5\x17"], "\xe4\xe6a\x01\x04R\xd9K\xe1b\xf9<\xcc$9>\xae\xc5\xfc5\x877\xef\xda\x9bl\xdf\x10\x04_\xce\xfb}\xf8\xec\x81\x11C\x82");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "T4\xde\xcb\x16\x85", "\xb8\xa4h"], "/\x8cE\x98\x17)c\x0e\xb0\xa7\xc5\xbfg\x90\xe4\xf9\x86\x19~\x83\x02\x1fW\xf8G\xd3\xac/\x1c\xc4\x91\xaa\x9d\xa1\xad\\F\x02\xeb");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "\x83\xd1\xe7\xf1", "\x1d5\x17"], "\xe4\xe6a\x01\x04R\xd9K\xe1b\xf9<\xcc$9>\xae\xc5\xfc5\x877\xef\xda\x9bl\xdf\x10\x04_\xce\xfb}\xf8\xec\x81\x11C\x82");
  sfx buildaliasarray(["I:\x87", "\xf0<\x96m?o\x8a", "\x8f\x8f\x0e\x12", "\x83\xd1\xe7\xf1", "\xb8\xa4h"], "/\x8cE\x98\x17)c\x0e\xb0\xa7\xc5\xbfg\x90\xe4\xf9\x86\x19~\x83\x02\x1fW\xf8G\xd3\xac/\x1c\xc4\x91\xaa\x9d\xa1\xad\\F\x02\xeb");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "\x95\xcd\x96\x04\x04", "\x1d5\x17"], "\x85\x02Qm#\xc2\x8cZPcU}\x85B\xb4\x1e\xe2\xc6\xc3\xd3\xa8A<\x93\xf5\xa9\xdc");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "\x95\xcd\x96\x04\x04", "\xb8\xa4h"], "\x11/\x84GvP\xe5\x17\xd19\xe2.\xfe\xa4\xa0_\xd6\xff0\xff\xf9\xc4\xfc\xe4~D\xa1");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "T4\xde\xcb\x16\x85", "\x1d5\x17"], "\xec\xdc\xc3\xfc\x06\x9e\x1c|u\xdbH\x8c\xc8Mhc\xeeTF\x82\x87P\\\xe2|\x1e\xde\v\xfcJ\xdd\x80");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "T4\xde\xcb\x16\x85", "\xb8\xa4h"], "\xac\xe1\xb2\xa7m\x9b\x04P\xa6\x90\xfdQ\x9bx\xf2\xf9\xa6-\x1f\xdf\x9f\xb1`\xa3\x9e\xf8\xf9\xa8\xfdTP\x02");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "\x83\xd1\xe7\xf1", "\x1d5\x17"], "\xec\xdc\xc3\xfc\x06\x9e\x1c|u\xdbH\x8c\xc8Mhc\xeeTF\x82\x87P\\\xe2|\x1e\xde\v\xfcJ\xdd\x80");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x88\x9b\x86{", "\x83\xd1\xe7\xf1", "\xb8\xa4h"], "\xac\xe1\xb2\xa7m\x9b\x04P\xa6\x90\xfdQ\x9bx\xf2\xf9\xa6-\x1f\xdf\x9f\xb1`\xa3\x9e\xf8\xf9\xa8\xfdTP\x02");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "\x95\xcd\x96\x04\x04", "\x1d5\x17"], "\x85\x02Qm#\xc2\x8cZPcU}\x85B\xb4\x1e\xe2\xc6\xc3\xd3\xa8A<\x93\xf5\xa9\xdc");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "\x95\xcd\x96\x04\x04", "\xb8\xa4h"], "\x11/\x84GvP\xe5\x17\xd19\xe2.\xfe\xa4\xa0_\xd6\xff0\xff\xf9\xc4\xfc\xe4~D\xa1");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "T4\xde\xcb\x16\x85", "\x1d5\x17"], "\xd7\xe3\x87t$\"\x9b\xb2c\xc3H7]{\x1b\xfcfk\xb1-O0\xa1\ar'(\xc0\x85g\xcd\xfc\x7fRo\x82\xf3`\t");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "T4\xde\xcb\x16\x85", "\xb8\xa4h"], "\f\x1d\xe3\xdfd\x0e\x0e\xc8\xec\vE=\a\x81d\xcf\xe3_\xaf28\xa1\x05\x7f\xaf\xce+\xcf9\xecA A\x83\xdeK\xf9\xae`");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "\x83\xd1\xe7\xf1", "\x1d5\x17"], "\xd7\xe3\x87t$\"\x9b\xb2c\xc3H7]{\x1b\xfcfk\xb1-O0\xa1\ar'(\xc0\x85g\xcd\xfc\x7fRo\x82\xf3`\t");
  sfx buildaliasarray(["I:\x87", "P\x15)\xa2f\xf8X", "\x8f\x8f\x0e\x12", "\x83\xd1\xe7\xf1", "\xb8\xa4h"], "\f\x1d\xe3\xdfd\x0e\x0e\xc8\xec\vE=\a\x81d\xcf\xe3_\xaf28\xa1\x05\x7f\xaf\xce+\xcf9\xecA A\x83\xdeK\xf9\xae`");
  return sfx;
}

function function_a970905633e0a04() {
  level._effect["\xcew\x96\xf6#\xf7dvF6\x90F'.>\xc3Bd"] = loadfxasset("\r\x04\x87\xbe\b\xeb\x05\xa1c\xff5B<\x13\xddB\x01\xa8*\xfb;s\x893\xec\xe2\xf7L\x9de\x99\xa6\x06<\xc5\x8e\xe0\xed\xd9\x06\x1f");
  level._effect["\xc1m\x81xZ\xc7\x85\xd1\x8a\xbe\xc7W.\xf8B\xe9\x16"] = loadfxasset("I\xc7\x98T\xe9J\xab\x15\xd6:N\xc5T\xb7C\xd8\xf8\x05\xdde\xc7\xda9\x95v\xbe\xda\xa7j\xb5B\xbb\bC\xf0q\xac\x025\x17\xf3");
  level._effect["p\xa6\x88\xdc\xec\xa3Dw\x17$\xd7+\x19P\xb2H\x14\xb0\x96\xbc\\"] = loadfxasset("K\xa7\xf28\x81\xbc\x01t \xb6\x97A\xc1\x93o1\x16\xea\x98\x18\bo\x9a\xce\x85W\xfb\xf8\xbd\xe5\xde\xe1;\xfa\xd5\x1d\x01\xb5^}\xec");
}

function buildaliasarray(keys, sfx) {
  i = 0;
  currentstruct = self;

  while(true) {
    if(keys.size > i + 1) {
      currentstruct function_894584ea4d4494d9(keys[i]);
    } else {
      currentstruct function_ca8e6673c9dda5b6(keys[i], sfx);
      break;
    }

    currentstruct = currentstruct.array[keys[i]];
    i++;
  }
}

function function_1fdd476bdd05e897(keys) {
  currentstruct = level.swim.sfx;
  i = 0;

  foreach(key in keys) {
    if(keys.size > i + 1) {
      currentstruct = currentstruct.array[key];
    } else {
      return currentstruct.array[key];
    }

    i++;
  }
}

function function_894584ea4d4494d9(key) {
  if(!isDefined(self.array)) {
    self.array = [];
  }

  if(!isDefined(self.array[key])) {
    self.array[key] = spawnStruct();
  }
}

function function_ca8e6673c9dda5b6(key, sfx) {
  if(!isDefined(self.array)) {
    self.array = [];
  }

  if(!isDefined(self.array[key])) {
    self.array[key] = sfx;
  }
}

function function_a2cac299a4437dfc() {
  if(isDefined(self.swim)) {
    return;
  }

  self.swim = spawnStruct();
  self.swim.breath = 100;
  self.swim.underwater = 0;
  self.swim.swimming = 0;
  self.swim.breathcritical = 0;
  self.swim.drowning = 0;
  self.swim.sprinting = 0;
  self.swim.heartbeat = 0;
  self.swim.sfxstate = "\r+x5";
  createswimoverlay();
  thread function_857d54743f13dc4b();
  thread deathcleanup();
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\xb9\xc3\x96\xf6P\xf8\xden\x8eDY\xf1U\xbc\xdf\xaa\xbe\xa0n\xa2\xd9");
  function_118e135e9301e25d();
  childthread function_85d1f754ac3ba122();
  childthread watchswim();
}

function function_85d1f754ac3ba122() {
  while(true) {
    utility::waittill_any("T\xef\xb2 \xbc\x04GR\xeev", "\x7f\xa00\x18\xc7\xbcs\xb6", "\xb9wK\xb6\xbeL\xe4\xca\xc2\xa34Z\x9bg\xaf\x8cK\xdca&\xb1\x95\x91\xd7+nd", ";\x8f\x10w\"(pEUG2/~g\xe7\xe8Q7:\xd0\x8b\xd5\xd7P\xdb\x97\xb87\xd5", "\xa0\xba\x88t\x9dQ\xc8H\x97\xb79\x9c\xdd", "\xecY\x1a-\x1b\x1b\xac\xfa\xb2<\xd2\xe8");
    function_118e135e9301e25d();
  }
}

function function_118e135e9301e25d() {
  isplayerswimming = self isswimming();
  var_31a6efb610c1ab73 = [[level.swim.var_dd44b9ee2a91cdad]]();

  if(var_31a6efb610c1ab73) {
    function_8daffee526519bb9();
  } else if(isplayerswimming && !var_31a6efb610c1ab73) {
    function_d2d963918da24c84();
  } else {
    function_333ecdbb0a2dd441(1.5);
  }

  if(var_31a6efb610c1ab73 && !self.swim.underwater) {
    childthread function_7ccdcc43483ed789();
  }

  if(!var_31a6efb610c1ab73 && self.swim.underwater) {
    childthread function_8af4ddaf34194415();
  }

  self setclientomnvar("j\fkj\x9fk\xb8COp\x06\x8f\x12\xf9\xad\xb2", self.swim.underwater);
}

function watchswim() {
  while(true) {
    utility::waittill_any("T\xef\xb2 \xbc\x04GR\xeev", "\x7f\xa00\x18\xc7\xbcs\xb6", "\xa0\xba\x88t\x9dQ\xc8H\x97\xb79\x9c\xdd", "\xecY\x1a-\x1b\x1b\xac\xfa\xb2<\xd2\xe8");
    function_6d8b241b07835257();
  }
}

function function_6d8b241b07835257() {
  if(function_5d60332a20258d13() && !self.swim.swimming) {
    childthread playerswimming();
  }

  if(!function_5d60332a20258d13() && self.swim.swimming) {
    childthread function_930b29bb1fbdb76d();
  }
}

function function_5d60332a20258d13() {
  return self isswimming();
}

function function_857d54743f13dc4b() {
  var_a4a689a98eba17de = [self.swim.swimoverlay, self.swim.var_e90cc86aca132c8f];
  var_a4a689a98eba17de = [self.swim.swimoverlay];
  utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\xf4\x9c \x0f\xaa\x9d\xbf,a\x16", "\xb9\xc3\x96\xf6P\xf8\xden\x8eDY\xf1U\xbc\xdf\xaa\xbe\xa0n\xa2\xd9");

  foreach(hudelm in var_a4a689a98eba17de) {
    if(isDefined(hudelm)) {
      hudelm destroy();
    }
  }
}

function deathcleanup() {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\xb9\xc3\x96\xf6P\xf8\xden\x8eDY\xf1U\xbc\xdf\xaa\xbe\xa0n\xa2\xd9");
  deathcleanup_internal();
}

function deathcleanup_internal() {
  uideathcleanup();
  function_c8b696fbd955bb97();
  scriptabledeathcleanup();
  clearbreathcritical();
  self.swim = undefined;
}

function uideathcleanup() {
  self setclientomnvar("\xdcw\x96m\xeb\x98\x9c\x95\v\xa3\xa1\xf5\xb5\xca\xd1\xcaN}\x86\xd2#V", 1);
}

function function_c8b696fbd955bb97() {
  function_333ecdbb0a2dd441(0.05);
}

function scriptabledeathcleanup() {
  utility::function_ed46f5d8bd142338("'Z\x13\xf1\xfe&\xeb\xca\x86\xdc", "r\xabd\xde>\xd2%>\xde\xf5");
  utility::function_ed46f5d8bd142338("\xee\xaf\xbe\xf3\r+CWN:\x01", "r\xabd\xde>\xd2%>\xde\xf5");
}

function function_8af4ddaf34194415() {
  self notify("\xe2-\x95\x1c\x813l\x15\x0f\xdd\x97X\xd5|\xd4>\x82\xe6\xdf\x8e\f\xf8l");
  self endon("\xe2-\x95\x1c\x813l\x15\x0f\xdd\x97X\xd5|\xd4>\x82\xe6\xdf\x8e\f\xf8l");
  self.swim.underwater = 0;
  childthread function_87cefc8570a8f0bd();
  childthread function_35ae3b9fd8432b49();
  childthread function_5367da07e90bac01();
  childthread function_e5c1e794f625da2f();
  clearbreathcritical();
  function_365335fe56e60847();
  self childthread[[level.swim.surfacefunc]]();
}

function function_7ccdcc43483ed789() {
  self notify("\xe2-\x95\x1c\x813l\x15\x0f\xdd\x97X\xd5|\xd4>\x82\xe6\xdf\x8e\f\xf8l");
  self endon("\xe2-\x95\x1c\x813l\x15\x0f\xdd\x97X\xd5|\xd4>\x82\xe6\xdf\x8e\f\xf8l");
  self.swim.underwater = 1;
  childthread function_a39822b94a6a9e28();
  childthread function_f3923cbd7b47ada5();
  childthread function_9e68e33a53e59de9();
  childthread function_671cf2a6351fd488();
  childthread function_71ac986a8ebdbba2();
  self childthread[[level.swim.descendfunc]]();
}

function playerswimming() {
  self notify("\x0e\x89s\x13\xc5\xd6:D\xc1,h\av\x90\xb5(\x1e\x86\x95n4");
  self endon("\x0e\x89s\x13\xc5\xd6:D\xc1,h\av\x90\xb5(\x1e\x86\x95n4");
  self.swim.swimming = 1;
  self childthread[[level.swim.enterfunc]]();
  params = spawnStruct();
  params.player = self;
  callback::callback(#"hash_217a0a0536f749b8", params);
}

function function_930b29bb1fbdb76d() {
  self notify("\x0e\x89s\x13\xc5\xd6:D\xc1,h\av\x90\xb5(\x1e\x86\x95n4");
  self endon("\x0e\x89s\x13\xc5\xd6:D\xc1,h\av\x90\xb5(\x1e\x86\x95n4");
  self.swim.swimming = 0;
  self childthread[[level.swim.exitfunc]]();
  params = spawnStruct();
  params.player = self;
  callback::callback(#"hash_c63f9d0c88a2d656", params);
}

function isplayerunderwater() {
  return isDefined(self.swim) && self.swim.underwater;
}

function isplayerswimming() {
  return isDefined(self.swim) && self.swim.swimming;
}

function function_333ecdbb0a2dd441(time) {
  if(self.swim.sfxstate == "\r+x5") {
    return;
  }

  self.swim.sfxstate = "\r+x5";
  self clearsoundsubmix("YJ\"\xd2\xd5\xd3\xf2\xd3\xdd\x10\x03\xd8\xd3\xbb\xd0\x03\x81\xdc\xa9sY\xa3\x947\x7fJ", 0.2);
  self clearsoundsubmix("\x83]\v1sHt\xe6g\xc2o\x92\xe8O-\xf3\x8b\xcc\x0f", 0);
  self setentitysoundcontext("0P\xd4\xe0\x06\x16\x82\xe3c\x92", "");
  self clearclienttriggeraudiozone(0.1);
}

function function_d2d963918da24c84() {
  if(self.swim.sfxstate == "\xf0<\x96m?o\x8a") {
    return;
  }

  self.swim.sfxstate = "\xf0<\x96m?o\x8a";
  self clearsoundsubmix("\x83]\v1sHt\xe6g\xc2o\x92\xe8O-\xf3\x8b\xcc\x0f", 0);
  self setentitysoundcontext("0P\xd4\xe0\x06\x16\x82\xe3c\x92", "\xb9\xf1+\x8b+Y\x16\xc7l\x8e99U");
  self clearclienttriggeraudiozone(0.1);
  self notify("E\xba<B$\x8e\x1aU\x06\f[\xa5B\xe7/\x1d");
}

function function_8daffee526519bb9() {
  if(self.swim.sfxstate == "\x91#B\xce\x8c\xbd\xcb$\x90") {
    return;
  }

  self.swim.sfxstate = "\x91#B\xce\x8c\xbd\xcb$\x90";
  self setentitysoundcontext("0P\xd4\xe0\x06\x16\x82\xe3c\x92", "p\x93\x8f5O\xdfNV\x14\xca");
  self setclienttriggeraudiozone("p\x93\x8f5O\xdfNV\x14\xca", 0.1);
  self notify("\x05\xa5\xc7G\xf0\xdc\xb73\xde\xdd\xc4\xf2n\xcdD\xfbc");
}

function function_a7663a9b89835dc9() {
  plrsfx = ";\x18-Y\x1ag\xf92\xcf\"\xd2\xca\x13XG\x8b\xd4\xcb\x8e\xa0\x815\x915u\xf6\r\xa3'";
  var_cc08188e2f78f677 = "p\xb1N\xeb\x98\xe4e\x16\x1d\x86\xaf\x9b\xee\x96\xad}\x0e\x85i\xe6\xebg,v";

  if(soundexists(plrsfx)) {
    self[[level.swim.playsoundfunc]](plrsfx);
  }

  if(soundexists(var_cc08188e2f78f677)) {
    self[[level.swim.playsoundfunc]](var_cc08188e2f78f677);
  }
}

function function_a0fa1d12c4bb14e2() {
  plrsfx = "\xb8\x15\x03\xd9\xe7\xc1M\xa4\xa1\xf8\x9f[\x9a\xf3\xaeU%a\x06~\xed\x10\x14E\xa8p\x9e";
  var_cc08188e2f78f677 = "";

  if(plrsfx != "") {
    if(soundexists(plrsfx)) {
      self[[level.swim.playsoundfunc]](plrsfx);
    }
  }

  if(var_cc08188e2f78f677 != "") {
    if(soundexists(var_cc08188e2f78f677)) {
      self[[level.swim.playsoundfunc]](var_cc08188e2f78f677);
    }
  }
}

function function_f61c9e13ca7e36c6() {
  plrsfx = "s\xc9\xe9@[\v\x9f?=\x14\xaa\xf0Y)\"\x94\x9c\xd5\xa0\xe3l\x84\xd3\xb1At4\xef^\x1f\xd6c\xa8]JO\xf8W";
  var_cc08188e2f78f677 = "=\xa16\xc0\x9d\x0elp=\x8ej\xe56g\xda\xd3\xb8\v\xc8\xc3x_\xeas\xd8\xd9";

  if(randomintrange(0, 1)) {
    var_cc08188e2f78f677 = "p\xb1N\xeb\x98\xe4e\x16\x1d\x86\xaf\x9b\xee\x96\xad}\x0e\x85i\xe6\xebg,v";
  }

  if(soundexists(plrsfx)) {
    self[[level.swim.playsoundfunc]](plrsfx);
  }

  if(soundexists(var_cc08188e2f78f677)) {
    self[[level.swim.playsoundfunc]](var_cc08188e2f78f677);
  }
}

function function_5367da07e90bac01() {
  if(!function_662ec63e13efb2bb()) {
    return;
  }

  function_b48a150e55c387dc();
  function_b2194c62f88e1e46();
}

function function_671cf2a6351fd488() {
  if(!function_662ec63e13efb2bb()) {
    return;
  }

  function_b5f5b03448aecf5d();
  function_fbcf5475b2d15253();
}

function function_b5f5b03448aecf5d() {
  utility::function_ed46f5d8bd142338("'Z\x13\xf1\xfe&\xeb\xca\x86\xdc", "p\x93\x8f5O\xffNV\x14\xca");
}

function function_b48a150e55c387dc() {
  utility::function_ed46f5d8bd142338("'Z\x13\xf1\xfe&\xeb\xca\x86\xdc", "r\xabd\xde>\xd2%>\xde\xf5");
}

function function_fbcf5475b2d15253() {
  utility::function_ed46f5d8bd142338("\xee\xaf\xbe\xf3\r+CWN:\x01", "\x89\xd5\x98b\xd8e\x9b\xa2\xcd\xe8\xca\x93");
}

function function_b2194c62f88e1e46() {
  utility::function_ed46f5d8bd142338("\xee\xaf\xbe\xf3\r+CWN:\x01", "r\xabd\xde>\xd2%>\xde\xf5");
}

function function_20ecd93d145f68ce() {
  self thread[[level.swim.var_493157cd579bb69b]]("\xc1m\x81xZ\xc7\x85\xd1\x8a\xbe\xc7W.\xf8B\xe9\x16", "\xb9wK\xb6\xbeL\xe4\xca\xc2\xa34Z\x9bg\xaf\x8cK\xdca&\xb1\x95\x91\xd7+nd", 3);
  utility::function_ed46f5d8bd142338("\xee\xaf\xbe\xf3\r+CWN:\x01", "\xf6x`\xdb\xbf\x95\x85\f\xb8\x88\x0e\xb9");
}

function function_c2474a9223d36f7f() {
  self thread[[level.swim.var_493157cd579bb69b]]("\xcew\x96\xf6#\xf7dvF6\x90F'.>\xc3Bd", "\xb9wK\xb6\xbeL\xe4\xca\xc2\xa34Z\x9bg\xaf\x8cK\xdca&\xb1\x95\x91\xd7+nd", 3);
}

function function_224ee521b6d82d95() {
  self thread[[level.swim.var_493157cd579bb69b]]("p\xa6\x88\xdc\xec\xa3Dw\x17$\xd7+\x19P\xb2H\x14\xb0\x96\xbc\\", "\xb9wK\xb6\xbeL\xe4\xca\xc2\xa34Z\x9bg\xaf\x8cK\xdca&\xb1\x95\x91\xd7+nd", 3);
}

function playsoundalias(plrsfx, npcsfx, soundsource) {
  self[[level.swim.playsoundfunc]](plrsfx, npcsfx, soundsource);
}

function function_e5c1e794f625da2f() {
  if(!function_662ec63e13efb2bb()) {
    return;
  }

  dof_surface();
}

function function_71ac986a8ebdbba2() {
  if(!function_662ec63e13efb2bb()) {
    return;
  }

  dof_descend();
}

function dof_surface() {
  if(!isDefined(level.dyndof)) {
    self disablephysicaldepthoffieldscripting();
  }
}

function dof_descend() {
  if(!isDefined(level.dyndof)) {
    self enablephysicaldepthoffieldscripting(1);
    self setphysicaldepthoffield(1, 200, 100);
    self setphysicalviewmodeldepthoffield(6, 100);
  }
}

function function_35ae3b9fd8432b49() {
  self.swim.swimoverlay fadeovertime(1);
  self.swim.swimoverlay.alpha = 0;
}

function function_f3923cbd7b47ada5() {
  self.swim.swimoverlay fadeovertime(0.05);

  while(true) {
    waittillframeend();

    if(function_662ec63e13efb2bb()) {
      updateswimoverlaycolor();
      function_3866af82e95f8061();
    }

    wait 0.05;
  }
}

function function_9e68e33a53e59de9() {
  pulsequaked = 0;
  var_f3f4dfbc57c1abdf = function_27ec7eddf18ef5c5();

  while(true) {
    waittillframeend();

    if(isbreathcritical()) {
      pulsetime = self.heartbeat.pulsetime;
      time = gettime();

      if(pulsetime > 0.9 && !pulsequaked) {
        if(function_662ec63e13efb2bb()) {
          factor = math::normalize_value(0, var_f3f4dfbc57c1abdf, self.swim.breath);

          if(factor > 0.66) {
            heartbeat = "\xfa\x06\xb0\x88&v{>sQ5}\x1e\xac";
          } else if(factor > 0.33) {
            heartbeat = "s\xc7\x7fmT\x1bzn\xcaoq\x81";
          } else {
            heartbeat = "\r\x95\xb0\xe4\x1dL\x95\x16\xe8$e\x85vy";
          }

          childthread heartbeat::function_24a414d24677f4ca(heartbeat);
        }

        pulsequaked = 1;
      } else if(pulsetime < 0.5 && pulsequaked) {
        pulsequaked = 0;
      }
    }

    wait 0.05;
  }
}

function function_a39822b94a6a9e28() {
  if(getdvarint(@ "hash_42deeb1fb385c72", 1) == 1) {
    self setclientomnvar("\xdcw\x96m\xeb\x98\x9c\x95\v\xa3\xa1\xf5\xb5\xca\xd1\xcaN}\x86\xd2#V", 0);
  }

  lightbubbles1 = function_6775c60cccfa34b9(0.66);
  lightbubbles2 = function_6775c60cccfa34b9(0.33);
  starttime = gettime();

  for(godmode = 0; true; godmode = swim_drown(godmode)) {
    while(self.swim.breath > 0) {
      godmode = 0;
      breathholdtime = [[function_250fc5ab71b8e3da()]]();

      if(getdvarint(@ "hash_2a4f08bc79265550")) {
        self.swim.breath = 100;
      } else {
        if(istrue(self.usingscubagasmask) && istrue(self.gasmaskequipped)) {
          self.swim.breath = 100;
        }

        if(!function_dac80a09858a49fb()) {
          self.swim.breath -= 100 / breathholdtime * 0.05;
          self.swim.breath = clamp(self.swim.breath, 0, 100);
        }
      }

      if(self isswimsprinting() && !self.swim.sprinting) {
        self setclientomnvar("olo\xe6\xf1\xd3\xc93\xcc\x93\x98)\x17\x97\xd7\xc4\xe1LO\xed4\x8e\xb3=", 1);
        self.swim.sprinting = 1;
      } else if(!self isswimsprinting() && self.swim.sprinting) {
        self setclientomnvar("olo\xe6\xf1\xd3\xc93\xcc\x93\x98)\x17\x97\xd7\xc4\xe1LO\xed4\x8e\xb3=", 0);
        self.swim.sprinting = 0;
      }

      if(!lightbubbles1 && function_6775c60cccfa34b9(0.66)) {
        lightbubbles();
        lightbubbles1 = 1;
      }

      if(!lightbubbles2 && function_6775c60cccfa34b9(0.33)) {
        lightbubbles();
        lightbubbles2 = 1;
      }

      if(!function_ce822d2395b6d666() && function_aaa20e190b8443f2()) {
        function_c4ba5caec553a2e0();
      }

      if(!isbreathcritical() && function_3a23113603a3ce6a()) {
        setbreathcritical();
        function_91f5bc4feb560d30();
      }

      self setclientomnvar("\xa66>\xd4by\xb7\xc6\x9cH\xa1\x14\x9di\x8e\xba@[V\xaa\xd9\xcbX-\xbc", int(self.swim.breath));
      self function_c1b5a242f52b68e6(int(self.swim.breath));
      wait 0.05;
    }
  }
}

function swim_drown(wasgodmode) {
  self endon("\xb6\xe8\x11\xb3\xa1/L}\xbe\x80m\n4\x96\x8ep\xb1\xcc");
  self notify("\xb6|\x02<'\xfa3\f\xd2\f\x94Rq\xfb\xf9\xcaY\x01_");
  drownweaponobj = undefined;

  if(wasgodmode) {
    wait 0.5;
  } else {
    function_dc21326258a5d6a();

    if(true) {
      self setclienttriggeraudiozone("\xb6\x81\x0e\x96L\xdf\x80\x9f\xfdP\xadX\x04tU\xc8\xa4[{\xc8U", 0);

      if(isDefined(level.drownvisionoverride)) {
        vision = level.drownvisionoverride;
      } else {
        vision = "F\x9c\xb7\xee\x9b\xd2\xcd\xd9";
      }

      self[[level.swim.visionsetfunc]](vision, 3.6);
      childthread function_f5711998f34bbca(4);
    }

    starttime = gettime();

    while(true) {
      waitframe();

      if(gettime() - starttime > 4000) {
        break;
      }
    }

    function_78598ed129a20de();
    drownweaponobj = self[[level.swim.drownfunc]]();
  }

  self dodamage(self.health + 10000, self.origin, self, self, "2a\\\xe1g5\xbf\xbf\xe0\xc6\x8c", drownweaponobj, "\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7");
  return true;
}

function function_1595d4d0647b28f(isdisable) {
  if(!isDefined(self.swim)) {
    return;
  }

  self.swim.var_19a159c6ed960124 = isdisable ? 1 : undefined;
}

function function_dac80a09858a49fb() {
  if(!isDefined(self.swim)) {
    return false;
  }

  return istrue(self.swim.var_19a159c6ed960124);
}

function function_f5711998f34bbca(timer) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level endon("\xd9Q\xe8=L\x9aj\xff\xf1(\x15\r");
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  for(waittimeplus = 0.6; true; waittimeplus = clamp(waittimeplus, 0, 1)) {
    function_1e9b06e6730d23e9();
    waittime = randomfloatrange(0.8, 1.15) + waittimeplus;
    wait waittime;
    timer -= waittime;

    if(self getclientomnvar("\xfe\xbe\v\xda\xa1\xa3\xd8\x97\xab\x8d\x85\x16\x8e\x03CO\xbd\x839\xf9\xcb\xe9\xdc\a\x92\xb0") == 3 || !self.swim.drowning || timer <= 0) {
      break;
    }

    waittimeplus -= 0.3;
  }
}

function function_a0712e2ff6730178() {
  if(function_2fc5aa221f94a0b4()) {
    if(true) {
      childthread function_1379d6559651b41b();
    }

    self.swim.drowning = 0;
    self notify("\xb6\xe8\x11\xb3\xa1/L}\xbe\x80m\n4\x96\x8ep\xb1\xcc");
  }
}

function function_1379d6559651b41b() {
  self endon("\xb6|\x02<'\xfa3\f\xd2\f\x94Rq\xfb\xf9\xcaY\x01_");
  self[[level.swim.visionsetfunc]]("\x8c\xe4ow\xcdK\xb9\xb3\xf5\x8d\x8de\x85\xc9Y2", 1);
  wait 1.05;
  self[[level.swim.visionsetfunc]]("", 1);
}

function function_87cefc8570a8f0bd() {
  while(self.swim.breath < 100) {
    self.swim.breath += 0.05 / [[level.swim.var_fcb2b6105dd4a97e]]() * 100;
    self.swim.breath = clamp(self.swim.breath, 1, 100);
    self setclientomnvar("\xa66>\xd4by\xb7\xc6\x9cH\xa1\x14\x9di\x8e\xba@[V\xaa\xd9\xcbX-\xbc", int(self.swim.breath));
    self function_c1b5a242f52b68e6(int(self.swim.breath));
    wait 0.05;
  }

  self setclientomnvar("\xdcw\x96m\xeb\x98\x9c\x95\v\xa3\xa1\xf5\xb5\xca\xd1\xcaN}\x86\xd2#V", 1);
}

function function_fce7971b89460385(amount, var_3ae8886319c85ce8) {
  self endon("\xe2-\x95\x1c\x813l\x15\x0f\xdd\x97X\xd5|\xd4>\x82\xe6\xdf\x8e\f\xf8l");
  breathfunc = level.swim.var_fcb2b6105dd4a97e;

  if(isDefined(var_3ae8886319c85ce8)) {
    breathfunc = var_3ae8886319c85ce8;
  }

  while(self.swim.breath <= amount) {
    self.swim.breath += 0.05 / [[breathfunc]]() * amount;
    self.swim.breath = clamp(self.swim.breath, 1, 100);
    self setclientomnvar("\xa66>\xd4by\xb7\xc6\x9cH\xa1\x14\x9di\x8e\xba@[V\xaa\xd9\xcbX-\xbc", int(self.swim.breath));
    self function_c1b5a242f52b68e6(int(self.swim.breath));
    var_f3f4dfbc57c1abdf = function_27ec7eddf18ef5c5();

    if(self.swim.breath > var_f3f4dfbc57c1abdf && isbreathcritical()) {
      clearbreathcritical();
      self clearsoundsubmix("\x83]\v1sHt\xe6g\xc2o\x92\xe8O-\xf3\x8b\xcc\x0f", 0);
      self setclienttriggeraudiozone("p\x93\x8f5O\xdfNV\x14\xca", 5);
    }

    heartbeatthreshold = function_6b7ee6a1dd501e3f();

    if(self.swim.breath > heartbeatthreshold && function_ce822d2395b6d666()) {
      function_365335fe56e60847();
    }

    wait 0.05;
  }
}

function function_91f5bc4feb560d30() {
  if(!function_662ec63e13efb2bb()) {
    return;
  }

  function_a7663a9b89835dc9();
  function_20ecd93d145f68ce();
}

function lightbubbles() {
  function_a0fa1d12c4bb14e2();
  function_c2474a9223d36f7f();
}

function function_1e9b06e6730d23e9() {
  if(!function_662ec63e13efb2bb()) {
    return;
  }

  function_f61c9e13ca7e36c6();
  function_224ee521b6d82d95();
}

function updateswimoverlaycolor() {
  var_f3f4dfbc57c1abdf = function_27ec7eddf18ef5c5();

  if(isDefined(level.var_7c5adddee8ed81c3) && [[level.var_7c5adddee8ed81c3]](#"player", #"updateswimoverlaycolor")) {
    colorfunc = [[level.var_ed8336091f09eea4]](#"player", #"updateswimoverlaycolor");
    color = [[colorfunc]](self.swim.breath, isbreathcritical(), var_f3f4dfbc57c1abdf, 100);
    self.swim.swimoverlay.color = color;
    return;
  }

  if(isbreathcritical()) {
    colormax = (0.2, 0.1, 0.1);
    colormin = (0.25, 0.05, 0.05);
    factor = math::normalize_value(0, var_f3f4dfbc57c1abdf, self.swim.breath);
  } else {
    colormax = (0.2, 0.2, 0.2);
    colormin = (0.1, 0.1, 0.1);
    factor = math::normalize_value(var_f3f4dfbc57c1abdf, 100, self.swim.breath);
  }

  color = math::factor_value(colormin, colormax, factor);
  self.swim.swimoverlay.color = color;
}

function function_3866af82e95f8061() {
  var_f3f4dfbc57c1abdf = function_27ec7eddf18ef5c5();

  if(!isDefined(self.heartbeat)) {
    assertmsg("<dev string:x24>");
  }

  if(isbreathcritical()) {
    minminalpha = 0.1;
    minmaxalpha = 0.2;
    maxminalpha = 0.5;
    maxmaxalpha = 0.75;
    factor = math::normalize_value(0, var_f3f4dfbc57c1abdf, self.swim.breath);
  } else {
    minminalpha = 0;
    minmaxalpha = 0.3;
    maxminalpha = 0.2;
    maxmaxalpha = 0.6;
    factor = math::normalize_value(var_f3f4dfbc57c1abdf, 100, self.swim.breath);
  }

  maxalpha = math::factor_value(maxmaxalpha, maxminalpha, factor);
  minalpha = math::factor_value(minmaxalpha, minminalpha, factor);
  self.swim.swimoverlay.alpha = math::factor_value(minalpha, maxalpha, self.heartbeat.pulsetime);
}

function function_aaa20e190b8443f2() {
  if(!isDefined(self.swim)) {
    return false;
  }

  breathheartbeatthreshold = function_6b7ee6a1dd501e3f();
  return self.swim.breath < breathheartbeatthreshold;
}

function isbreathcritical() {
  return self.swim.breathcritical;
}

function function_2fc5aa221f94a0b4() {
  return self.swim.drowning;
}

function function_ce822d2395b6d666() {
  return self.swim.heartbeat;
}

function function_3a23113603a3ce6a() {
  if(!isDefined(self.swim)) {
    return false;
  }

  var_f3f4dfbc57c1abdf = function_27ec7eddf18ef5c5();
  return self.swim.breath < var_f3f4dfbc57c1abdf;
}

function function_6775c60cccfa34b9(var_cf62c0f938163a01) {
  if(!isDefined(self.swim)) {
    return false;
  }

  lightbubblesthreshold = function_be7dd5eb9a7c8c4e(var_cf62c0f938163a01);
  return self.swim.breath < lightbubblesthreshold;
}

function clearbreathcritical() {
  self setclientomnvar("\xfe\xbe\v\xda\xa1\xa3\xd8\x97\xab\x8d\x85\x16\x8e\x03CO\xbd\x839\xf9\xcb\xe9\xdc\a\x92\xb0", 0);

  if(isDefined(self.swim)) {
    self.swim.breathcritical = 0;
    function_a0712e2ff6730178();
  }
}

function setbreathcritical() {
  self setclienttriggeraudiozone("\xb4o,\xfb\xb6\x8a\x03\x8b\xcf\xa7\x86s2\xce\xa9s\xb2\xef\xcc", 0);
  self.swim.breathcritical = 1;
  self setclientomnvar("\xfe\xbe\v\xda\xa1\xa3\xd8\x97\xab\x8d\x85\x16\x8e\x03CO\xbd\x839\xf9\xcb\xe9\xdc\a\x92\xb0", 1);
}

function function_365335fe56e60847() {
  self.swim.heartbeat = 0;
}

function function_c4ba5caec553a2e0() {
  self.swim.heartbeat = 1;
  self notify("_\xbb\x82\x86!\x93\x15\xaa\xed3\xf2\xd9\x0f\x9b\xa8\xa3p\xafW");
}

function function_dc21326258a5d6a() {
  self.swim.drowning = 1;
  self setclientomnvar("\xfe\xbe\v\xda\xa1\xa3\xd8\x97\xab\x8d\x85\x16\x8e\x03CO\xbd\x839\xf9\xcb\xe9\xdc\a\x92\xb0", 2);
}

function function_78598ed129a20de() {
  self setclientomnvar("\xfe\xbe\v\xda\xa1\xa3\xd8\x97\xab\x8d\x85\x16\x8e\x03CO\xbd\x839\xf9\xcb\xe9\xdc\a\x92\xb0", 3);
}

function function_4f4d30b479ba4fd0() {
  if(!isDefined(self.swim)) {
    return false;
  }

  heartbeatthreshold = function_6b7ee6a1dd501e3f();
  return self.swim.breath < heartbeatthreshold;
}

function function_6b7ee6a1dd501e3f() {
  breathholdtime = [[function_250fc5ab71b8e3da()]]();
  var_1a8996308bb922e1 = breathholdtime - 6;
  return var_1a8996308bb922e1 / breathholdtime * 100;
}

function function_27ec7eddf18ef5c5() {
  breathholdtime = [[function_250fc5ab71b8e3da()]]();
  var_caede882e92a0eb6 = [[level.swim.var_5dd94eede306043b]]();
  return var_caede882e92a0eb6 / breathholdtime * 100;
}

function function_be7dd5eb9a7c8c4e(var_cf62c0f938163a01) {
  breathholdtime = [[function_250fc5ab71b8e3da()]]();
  var_caede882e92a0eb6 = [[level.swim.var_5dd94eede306043b]]();
  lightbubblestime = var_caede882e92a0eb6 + var_cf62c0f938163a01 * (breathholdtime - var_caede882e92a0eb6);
  return lightbubblestime / breathholdtime * 100;
}

function function_4e5b950863bc54da() {
  breathholdtime = [[function_250fc5ab71b8e3da()]]();
  return breathholdtime * self.swim.breath / 100;
}

function createswimoverlay() {
  self.swim.swimoverlay = newclienthudelem(self);
  self.swim.swimoverlay.sort = 1;
  self.swim.swimoverlay.x = 0;
  self.swim.swimoverlay.y = 0;
  self.swim.swimoverlay.alignx = "=\xff0b";
  self.swim.swimoverlay.aligny = "\x1d Q";
  self.swim.swimoverlay.foreground = 0;
  self.swim.swimoverlay.lowresbackground = 1;
  self.swim.swimoverlay.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.swim.swimoverlay.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  self.swim.swimoverlay.alpha = 0;
  self.swim.swimoverlay setshader("\xe8\xed\b\x14\xea\xc0R|\xbeB\xb8L-\x1d\x8eN\x11", 640, 480);
}

function function_274c13c5762302f0(msg1, msg2, timer) {
  self endon(msg1);
  self endon(msg2);
  wait timer;
}

function function_662ec63e13efb2bb() {
  return !isDefined(self.usingremote);
}

function function_250fc5ab71b8e3da() {
  if(isDefined(self.var_3775369203f49857)) {
    return self.var_3775369203f49857;
  }

  return level.swim.var_3775369203f49857;
}