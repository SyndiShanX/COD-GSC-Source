/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\load_code.gsc
**************************************/

#using script_3254d90a426b13a0;
#using script_6a04c207a6c69f43;
#using scripts\common\ai;
#using scripts\common\ai_devgui;
#using scripts\common\dev;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\nvg\nvg_player;
#using scripts\sp\scripted_weapon_assignment;
#using scripts\sp\starts;
#using scripts\sp\utility;
#namespace load_code;

function private autoexec __init__system__() {
  system::register(#"hash_6999f162b67c3039", #"val", &pre_main, undefined);
}

function pre_main() {
  function_ab0718db7507034d();
  level.var_fd2bb82eb350094c = &utility_sp::set_player_demeanor_val;
}

function function_ab0718db7507034d() {
  if(isDefined(level.var_ab0718db7507034d)) {
    return;
  }

  val::register("\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 1, 0, "\x127\xca\x8d3", &set_allow_crosshair, "~\xa9\xccdcE");
  val::register("\x96\xe3=}w\xfc\xf6\xb8\x90k6\x83\x82\xdc\x0f", 1, 0, "\x127\xca\x8d3", &function_31a30371cfe3df5e, "~\xa9\xccdcE");
  val::register("7A\x85$\x85ldk\x11\x1cpf8\x85", 0, 1, "\x127\xca\x8d3", &function_620a868d8db46ac9, "~\xa9\xccdcE");
  val::register("\x86X7\x8c\xdc", 1, 0, "\x127\xca\x8d3", &function_533659d9933752f9, "~\xa9\xccdcE");
  val::register("\x8b\x13\xa9\x82!5Q\xc9\xe8L\xfc1 P\x7f\xa6]\x0f\xb3\x11", 1, 0, "\x127\xca\x8d3", &function_dbd7951dd9a48993, "~\xa9\xccdcE");
  val::unregister("\x18\xaa\b");
  val::register("\x18\xaa\b", 1, 0, "\x127\xca\x8d3", &function_d705b46e5505082f, "~\xa9\xccdcE");
  val::register("\xd8L\v\x9b\xcb\xb6\x7f\a18\f", 1, 0, "\x127\xca\x8d3", &function_67c49fd7aba5372c, "~\xa9\xccdcE");
  val::register("\xf92X\xc7\xc7\x84\xc0+2\xe9\xc7\x82\xd1\xf0\xe7Z\b\xe6\xf1\"\x82", 0, 0, "\x127\xca\x8d3", &function_d1fdb5855a543eb5, "~\xa9\xccdcE");
  val::register("`QW\xf5\xf2\x1b\xd6\xd7\x03\xd6\xce\bf\xd6", 1, 0, "\x127\xca\x8d3", &function_2bf4bc8247450137, "~\xa9\xccdcE");
  val::register("\xa9=\x8a\xdbR\x85\xa1\xb4\xaa8\a\xb0(\x91\xd2\xa6\xbfN\x87K\xb6\b\x99\x90\xae\xc1\b<", 1, 0, "\x127\xca\x8d3", &function_4d7e97f8d0d1eef9, "~\xa9\xccdcE");
  val::register("\xb4\xad\xda\xeas\xac\xafgX\xe6", 0, 1);
  val::register("\xc3<\xbcpe\xd4\xf6=\x8d5\xbc\xeb\x18A", 0, 1, "\x127\xca\x8d3", &function_7ec9db3cd1d0d994, "~\xa9\xccdcE");
  val::register("_d\x89\xf5\b(QU\xf5h\xf6\xdf\xe1\xed\x8b\x9fE\x95s", 1, 1, "\x127\xca\x8d3", &function_9ab2aa034122c50c, "~\xa9\xccdcE");
  val::register("\x8f(]2CB&\x0fl\xf8\x15z\xa9&J\x8c\xd5ju ", 0, 1, "\x127\xca\x8d3", &function_5434cd6394df2559, "~\xa9\xccdcE");
  val::register("d\xbc;\x03\x90\xa7\xde\xc6\xef\xb2z\xcb]\xc1\x15\x97\x1f", 0, 1, "\x127\xca\x8d3", &function_1e25632916cbbf6d, "~\xa9\xccdcE");
  val::register("\xbe\x01\xf7\xe3W\xce\x8a\xa9\xdf", 0, 1, "\x127\xca\x8d3", &function_30982b600e4cd436, "~\xa9\xccdcE");
  val::register("\xe7\x92\xbf\x14\xb1\xdd\xdct\x03\x04\xb5\xb6\x1b", [0, 0], [0, 0], "\x127\xca\x8d3", &function_32b946c7cade55b0, "~\xa9\xccdcE");
  level.var_ab0718db7507034d = 1;
}

function init_values() {
  if(isDefined(level.values_ref)) {
    return;
  }

  val::pre_main();
  function_ab0718db7507034d();
}

function init_level() {
  assert(!isDefined(level.script), "<dev string:x24>");
  starts::init_starts();
  level.script = tolower(getDvar(@ "g_mapname"));
  println("<dev string:x50>", level.script);
  level.mapname = tolower(getDvar(@ "g_mapname"));
  println("<dev string:x62>", level.mapname);
  level.mapinfoname = function_946d923474ec36d7(@ "hash_5f27cf2dc9f8eb42");
  assert(isxhashasset(level.mapinfoname));
  println("<dev string:x75>", getxhashsourcename(level.mapinfoname));
  level.framedurationseconds = level.frameduration / 1000;
}

function init_global_dvars() {
  setsaveddvar(@ "hash_1cc4e4a2542af7f5", "\xfe");
  setsaveddvar(@ "cg_fovscale", "\x87");
  setsaveddvar(@ "hash_9b1982d1c7accfb2", !utility_sp::is_trials_level());
  setsaveddvar(@ "hash_ae042d64567123fd", 0);
  setsaveddvar(@ "hash_79a0c60ce3306d67", "\xe6\xbf\x90}\xce\r%n\xf3\xc4}=!\x7f\xa5\xbe\xdf\x06\x80\t\xaf\xeb\xca");
  setsaveddvar(@ "hash_79a0c50ce3306b34", "\x18\xc5\a\a\x8c@\x81\xb8p\x1cF\x10\x06\x8b\x0e\a\x8c\x10\x98\x17\xc00\x03");
  setsaveddvar(@ "hash_79a0c80ce33071cd", "2\xb2x/\xd5\xba;b\xcd|OrUV\x84[\xf3`\ne\xfe\xa4\xdf");
  setsaveddvar(@ "hash_79a0c70ce3306f9a", "(,\xa6\xbd\x13\xf6\xd2\xfa\xa0\xfcm\x1a\xf1\xcfa\x04\x1f\xcb\\\x94`d/");
  setsaveddvar(@ "hash_79a0c20ce330649b", "+\xb7\xcb\b\x9bP\xb9.\xeai\xee\xdf\xe0U\xef\x91\xb8\x05\"\xf1^\x12\xb4");
  setsaveddvar(@ "hash_79a0c10ce3306268", "\x1aiQ\xb0\x9aFc\xc1\xabj;\xb0\x1f\x06\x86\x96\x16oa\xdbt1(");
  setsaveddvar(@ "hash_79a0c40ce3306901", "\xef\xb7\xb1\xcb\xe9^5[\xecS\x81\xcf(\x81Y\xff#\xfd[\x8c\xf1>`");
  setsaveddvar(@ "hash_79a0c30ce33066ce", "\xe6\xbf\x90}\xce\r%n\xf3\xc4}=!\x7f\xa5\xbe\xdf\x06\x80\t\xaf\xeb\xca");
  setdvarifuninitialized(@ "hash_f07ae454d79d2299", !isDefined(level.gamemodebundle) || !istrue(level.gamemodebundle.damagefeedback));
  setdvarifuninitialized(@ "hash_46d6ca4c8b20782d", 0);
  setdvarifuninitialized(@ "hash_2fb5684532ad1a80", !isDefined(level.gamemodebundle) || !istrue(level.gamemodebundle.hitmarkers));
  setsaveddvar(@ "hash_191cc88f6727f6c8", 0);
}

function init_global_omnvars() {
  setomnvar("\xd5\xd2\xd7gY\xe8t\xf6\xc6\xdbv+\xe4}:ex\xe8", "d\x88\x10l\xb7\xec_V\xe0\x15kGa\xf8u\x04u");
}

function init_global_precache() {
  precacheshader("\x8a-\v\xa1\xbd");
  precacheshader("e\xac\x11}\xfd");
  precacheshader("cwy\xb6\x94g}Ht\xf2h\xed\xd0X");
  precachemodel("\xd4\xf4");
  precachemodel("\xec\xbfK|\au\xcd\xc2\x19<");
  precachemodel("fJn\xc8\x10r\xf3\x94\xf6");
  precachemodel("$Im\x1eE\n\xdayl\xf5\x86Q\xb6UT5\xd6\x1c");
  precachemodel("M\xe8\r\xa6\x95m\x1b\v\x99\x93\xb3\t\xb67~F\x1c\xf6\x8d");
  precacherumble("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");
  precacherumble("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
  precacherumble("R\xd3\xafp\xb0w(\x97]l4rp\x9f");
  precacherumble("\xc2r\xd1i\xd8\x8dYr\xbc\xbe\x9cukb\xd8V");
  precacherumble("k\x1f{3\xf4NLD\x83\xb1\xda");
  precacherumble("\xffu\xa2Z \xdd\xa6c\x86\xa5");
  precacherumble("\xad\xcc\xb2\xa8K\xd0\xac\x8f");
  precacheshader("\x01d\xd8\x91\xec\xb8\xc7\xe2\x96uF\xac\x1f\xb0FP\xb3J\xce\xf7OX\x98\xe9\xd4T\x1a");
  precacheshader(":\xe5\xfcu\xa9\xc1\xfc\x94\xe0\x90-\x86\xcc4\b\f1\xf4\x95\x03\xb2\xf4\xb7\x186-0");
  precacheshader("!\xa4\x1a\xf8:_\xa9p-\x9e\xc9k5Q\x1e\x13\xbcN\xd0\xc0x\xe7+p y\xf7");
  precacheshader("\xbb\xd2dv\xf5\xd99\x852i\x95\xdcG\xbe\x8e\xf6p\xfa\xa3o\xd7b\xf6\xd1\xa3\xed\xb5");
}

function init_funcs() {
  utility::create_func_ref("u\xdce\x85\x9b\xa5[\xe8\x93\xcae", &useanimtree);
  utility::create_func_ref("n\x95tX\xb9\xb4\xd6", &setanim);
  utility::create_func_ref("\b\x15\xf0\x91\x14\xe9\xce$d\x9ds", &setanimknob);
  utility::create_func_ref("^R)x\r\x19(\xf11i\x17\x8d\xbaO\xd1%]\x83", &setflaggedanimknob);
  utility::create_func_ref("\x8b\x1b\x03\"+|\rzR\t\x87\x1b\x92\x16\xfa\xb4\xc57hZ\xdd]?]9", &setflaggedanimknobrestart);
  utility::create_func_ref("'\xeep\xd6\x18l\x18\xd9\xf4\xd5\x85mvJ", &setanimlimited);
  utility::create_func_ref("\xa1\x86wC\xaaQ\xdb\x11c\xdf]", &setanimtime);
  utility::create_func_ref("\xeb\xc5\xf0\x10\x9fd<\x9f\x98{\x11", &getanimtime);
  utility::create_func_ref("p\xaa\xf2\x8d\x16\xafB`\xf7\xd7\x1f\x1b\xd0", &getanimlength);
  utility::create_func_ref("\xf8v\xa4\xde\x98.6\x03\"", &clearanim);
  utility::create_func_ref("\x7f<\\\"", &kill);
  utility::create_func_ref("\x1e\xde8\xae\xb5\x16}n\x117\xda\xd2", &magicgrenade);
  utility::create_func_ref("\xbc\x95\xdb\x88\xd8\r\x15?9\x05rZ", &connectpaths);
  utility::create_func_ref("\xe7\xd58^w\xb6\xfaPHKU\x91o\x85p", &disconnectpaths);
  utility::create_func_ref("\xd4}\xe0\xc7\x8e\xb9\x8a)w\x83zx\xb6i\xc0\xdc\xde\xb7", &makeentitysentient);
  utility::create_func_ref("E\xe0\xb18[\xe8p\xabz\xab\f\xf4", &laserforceon);
  utility::create_func_ref("\xc6\xb07V'\x91\xed9lYz3\x99", &laserforceoff);
  utility::create_func_ref("\xba\x0e\x11z\xc7\x93\xfa\x97\xe2\x9c\x8d\vF\x03", &badplace_delete);
  utility::create_func_ref("3\x11C\xd3\x98Y\xb4\b\xa8\xac\xcc\x8c+O\x013", &badplace_cylinder);
  utility::create_func_ref("U\xea\xcf\xb8-3\xc3P\xfb\xfb/\xe58#Y\xeb\xcdt", &freeentitysentient);
  utility::create_func_ref("\xe8\xc72\x19\xad\x9c\xe2F\xdf\xfa\xe7\xa9\x16\xa0\xc07j\x96\xd9E", &laserforceoff);
  utility::create_func_ref("\xc6\xb07V'\x91\xed9lYz3\x99", &laserforceoff);
  utility::create_func_ref("GN\xfc81\xe9\xd6\xdf32", &getspawner);
  utility::create_func_ref("a\x14\x0f\x10\xe7k\x1f\xaf\xaf\xcbr\xb6", &utility_sp::has_color);
  utility::create_func_ref("\xeb\xd8A\xd8\xc7\x9f\xd5\bP\x17\xf0L\xfe\xed\xec\xca", &utility_sp::play_sound_on_tag);
  utility::create_func_ref("8\xc6\x85/\x1b\xdb\xb7\xe0\xdcou\xdc\xc8\xfa\xf6n\xebt,g", &utility::play_loop_sound_on_tag);
  utility::create_func_ref("\x9f\xe9\x8c\xf4\x90\xa0\xad\x1d\xc5\xf2/@\xe8o=F\r*\xac", &utility_sp::play_sound_on_entity);
  utility::create_func_ref("\xaeAT\xec\xb4@\xd3-\xd3=u\n\x0f\xc6h[NC\"\xc9!X\xda", &utility::play_loop_sound_on_entity);
  utility::create_func_ref("\x01\xd8\xd7z:Dv`\x0e\xfa\xf7\xb8", &utility_sp::display_hint);
  utility::create_func_ref("\x18\x9a\x90o\x18[\xa9\x11F\x149\x17P\x81{", &utility_sp::add_hint_string);
  utility::create_func_ref("=\xa9\x8a\xbb\x90\x81\x97\xf8", &utility_sp::spawn_ai);
  utility::create_func_ref("\xe6uh\xe3\b\xe2\x82!c\x9a;P", &ai::spawn_failed);
  utility::create_func_ref("\xe5\x01\xf6S\xf9\xcb\x9e\xe7?\x16-\x7f{\x8c\x10YY\x1e\x7f", &utility_sp::dronespawn_bodyonly);
  utility::create_func_ref("\f\xe3\x80Ox\x92wuV\xf7\xc2\xed\x1f", &utility_sp::bodyonlyspawn);
  utility_sp::setupglobalcallbackfunctions_sp();
  visibility_mode::main(&namespace_744fa97fe424d22c::function_327d62fc830b430f);
  level.dopickyautosavechecks = 1;
  level.autosave_threat_check_enabled = 1;
  level.getnodefunction = &getnode;
  level.getnodearrayfunction = &getnodearray;
  level.addaieventlistener_func = &addaieventlistener;
  level.getspawnerarrayfunction = &getspawnerarray;
  level.fnbuildweapon = &utility_sp::make_weapon;
  level.fnbuildweaponspecial = &utility_sp::make_weapon_special;
  level.fnscriptedweaponassignment = &scripted_weapon_assignment::getscriptedweapon;
}

function init_global_variables() {
  if(!isDefined(level.missionfailed)) {
    level.missionfailed = 0;
  }

  if(!isDefined(level.g_effect)) {
    level.g_effect = [];
  }

  if(!isDefined(level.var_b250be35220acdbb)) {
    level.var_b250be35220acdbb = 0;
  }

  if(!isDefined(level.starttime)) {
    level.starttime = gettime();
  }

  thread do_level_first_frame();
}

function init_objective_colors() {
  my_textbrightness_default = "J5\t@v\x84\x90z\xa57\xc7";
  my_textbrightness_90 = ">f\xf9\xc8>\xf0\t\x12\xd0u-";
  var_df6a3aaae6013a63 = "\xd2\xef\x80\f\xaf\xf9\xa7\xdb\xc8\xeb\x1a0s\x95";
  setsaveddvar(@ "con_typewritercolorbase", my_textbrightness_default);
}

function private set_allow_crosshair(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  thread set_allow_crosshair_delayed(b_value);
}

function private set_allow_crosshair_delayed(b_value) {
  self notify("\x9b\xacG\xaf,cl\xed\xbb\xd7\x1b\x9c\xbd\x9b\xcd\r\x16Kr\xd7\x19e\xd8,\xe5e#");
  self endon("\x9b\xacG\xaf,cl\xed\xbb\xd7\x1b\x9c\xbd\x9b\xcd\r\x16Kr\xd7\x19e\xd8,\xe5e#");
  waitframe();
  setsaveddvar(@ "cg_drawcrosshair", b_value);
}

function private function_31a30371cfe3df5e(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  if(b_value) {
    utility::flag_clear("\xeee,\xe0{\xdc\xfa\xb9\xb1\vn\x9b\xd2\x9b\xec\xfa\xb7\x99\xcc");
    return;
  }

  utility::flag_set("\xeee,\xe0{\xdc\xfa\xb9\xb1\vn\x9b\xd2\x9b\xec\xfa\xb7\x99\xcc");
}

function private function_620a868d8db46ac9(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(b_value) {
    level.player utility::ent_flag_clear("\x95\x132\xa7+t\xcf\xfc\xf2\xbf4\x0f/4\x93\x1d_\xff)\x0f)d");
    return;
  }

  if(!level.player utility::ent_flag_exist("\x95\x132\xa7+t\xcf\xfc\xf2\xbf4\x0f/4\x93\x1d_\xff)\x0f)d")) {
    level.player utility::ent_flag_init("\x95\x132\xa7+t\xcf\xfc\xf2\xbf4\x0f/4\x93\x1d_\xff)\x0f)d");
  }

  level.player utility::ent_flag_set("\x95\x132\xa7+t\xcf\xfc\xf2\xbf4\x0f/4\x93\x1d_\xff)\x0f)d");
}

function private function_533659d9933752f9(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  self sethandsoccupied(!b_value);
  self notify("\x86X7\x8c\xdc", b_value);
}

function private function_d705b46e5505082f(value) {
  assert(isPlayer(self), "<dev string:xa3>");

  if(!isDefined(value)) {
    value = 1;
  }

  if(value != 1) {
    thread nvg_player::disable_nvg_proc(1, value == -1);
    return;
  }

  thread nvg_player::disable_nvg_proc(0);
}

function private function_dbd7951dd9a48993(b_value) {
  if(!isDefined(b_value)) {
    b_value = 1;
  }

  if(istrue(b_value)) {
    self showlegsandshadow();
    return;
  }

  self hidelegsandshadow();
}

function private function_67c49fd7aba5372c(b_value = 0) {
  self setautopickup(istrue(b_value));
}

function private function_d1fdb5855a543eb5(b_value = 0) {
  self usehintsinvehicle(istrue(b_value));
}

function private function_2bf4bc8247450137(b_value) {
  if(!isDefined(b_value)) {
    b_value = 0;
  }

  setsaveddvar(@ "hash_fa84e9dc55b9d406", b_value);
}

function private function_4d7e97f8d0d1eef9(b_value = 0) {
  assert(isPlayer(self));
  self.var_b3e159502d6865f4 = istrue(b_value);
}

function private function_9ab2aa034122c50c(value = 1) {
  self.var_8ccbc951cdcc0229 = value;
}

function private function_7ec9db3cd1d0d994(b_value = 1) {
  if(isPlayer(self)) {
    if(istrue(b_value)) {
      self hideviewmodel();
      return;
    }

    self showviewmodel();
  }
}

function private function_5434cd6394df2559(b_value = 1) {
  assert(isPlayer(self));
  setsaveddvar(@ "hash_157a01b600fd018", b_value);
}

function private function_1e25632916cbbf6d(b_value = 1) {
  self function_537c7265402d978e(b_value);
}

function private function_30982b600e4cd436(b_value) {
  if(level.player isps4player() || level.player isxb3player()) {
    b_value = 1;
  }

  setsaveddvar(@ "hash_6e3f8cef6be16b33", !istrue(b_value));
}

function private function_32b946c7cade55b0(rate) {
  assert(isPlayer(self));
  defval = [0, 0];

  if(!isDefined(rate)) {
    rate = defval;
  }

  if(!isarray(rate)) {
    rate = [rate, rate];
  }

  self capturnrate(rate[0], rate[1]);
}

function do_level_first_frame() {
  level.first_frame = 1;
  wait 0.05;
  level.first_frame = -1;
}

function post_load_functions() {
  utility::flag_set("\xad\v\xac\x80SP:\x8f\x9c\xa9\xec\xb3\xca");

  if(isDefined(level.post_load_funcs)) {
    foreach(func in level.post_load_funcs) {
      [[func]]();
    }
  }
}

function function_6bc77ce6df91d9e7() {
  namespace_8527a3aac209af00::function_4cc5ab4e5fbdc72e();
  createprintchannel("<dev string:xc7>");
  debug::function_45363b6414f41e5b();
  debug::maindebug();
  dev::init();
}

function function_bb2be304a375da74() {
  debug::maindebugpostload();
  ai_devgui::function_e2b40c60922f9148();
}

function delete_on_load() {
  utility::array_delete(getEntArray("!Zf\xb9\x8d\x97\xbco{\x0e\xaa\x83\xc3\xdd", #targetname));
  utility::delaythread(0.05, &utility::array_delete, getEntArray("$\xbc}\x18p\xe5\a\xff/\x1cT\x87V6x\xc1T\xeeY\xef\xac\xea\xb2", #targetname));
}

function post_cl_pregame() {
  while(getdvarint(@ "cl_pregame")) {
    waitframe();
  }

  utility::flag_set("\xf9\xd01l\xbc7a\xa5<+\xa4\x86g5>");
}