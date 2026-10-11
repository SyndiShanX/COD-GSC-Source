/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_654ffaecd1155946.gsc
*************************************************/

#using script_2dcc22f11f14cb9;
#using script_3ef1b643f06851a8;
#using script_72ef6b9f0cf1f55a;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\hud_util;
#using scripts\sp\player;
#using scripts\sp\utility;
#namespace namespace_86ac7d9988dd9ad8;

function function_486c0f87d126bd24() {
  function_69a1f02a7a9613cb();

  setdevdvarifuninitialized(@ "hash_c96167e2d3de211", 1);
  setdvarifuninitialized(@ "hash_f8078e31e611f1e6", 0);
  setdevdvarifuninitialized(@ "hash_c0009c0cc6d51808", 1);
}

function private function_69a1f02a7a9613cb() {
  precacheshader("ui_bomber_drone_overlay");
  function_392903a533b9c762();
}

function private function_392903a533b9c762() {
  add_hint_string("cctv_cycle_camera_hint", &"SP_JUP_SURGE/CCTV_CYCLE_HINT", &function_f6ed5c07350d89ef);
  add_hint_string("cctv_scan_camera_hint", &"SP_JUP_SURGE/CCTV_SCAN_HINT");
}

function function_f6ed5c07350d89ef() {
  return flag("switching_camera");
}

function function_8dc553bce7bf1b35() {}

function function_ad8155e88c085aeb(var_c4ac1d963dccaf1c, var_c1978323e243becf, b_disable_zoom) {
  if(!isDefined(var_c1978323e243becf)) {
    var_c1978323e243becf = 1;
  }

  if(!isDefined(b_disable_zoom)) {
    b_disable_zoom = 0;
  }

  if(flag("cctv_end")) {
    flag_clear("cctv_end");
  }

  if(flag("CCTV_zoom_disabled")) {
    flag_clear("CCTV_zoom_disabled");
  }

  if(b_disable_zoom) {
    flag_set("CCTV_zoom_disabled");
  }

  if(!isDefined(level.start_cam)) {
    level.start_cam = 0;
  }

  level.player.var_d5234a010d66e1a5 = level.player.origin;
  level.player.var_6de5fc8b2865186a = level.player.angles;
  level.player lerpfovscalefactor(0, 0);
  level.var_ca7b00b4c1e62f31 = level.player getbobrate();
  level.player disableweapons();
  flag_set("flag_cctv_sequence_started");
  level notify("cctv_enabled");
  level.player playSound("surge_cctv_start");
  level.player setsoundsubmix("surg_cctv_mix");
  level thread namespace_85a51fd192b9a590::function_8a715a3ebbf310bf();
  function_3fc0e08182d8d965();
  level.player scripts\sp\player::disable_player_weapon_info();
  level.player setcinematicmotionoverride("disabled");

  if(isDefined(var_c4ac1d963dccaf1c)) {
    if(level.cams[var_c4ac1d963dccaf1c] == level.current_cam) {
      level.current_cam function_3bca028b81b9315(1);
      level.current_cam thread function_df92850503fdbc8b();
      thread function_64196226b4e5c384();
    } else {
      level.cams[var_c4ac1d963dccaf1c] thread function_11671c2e250e9320();
    }
  }

  battlechatter_off();
  thread function_2aaf51245e5ed210();

  if(getdvarint(@ "hash_c96167e2d3de211", 1)) {
    thread function_7a2e20471c45d91b();
  } else {
    function_ae0d80a4899b77e0();
  }

  if(var_c1978323e243becf) {
    thread function_dfee9368a79e1912();
  }

  thread securitycam_slow_look();
  flag_set("cctv_init_done");
  wait 2;
  flag_set("cctv_enable_camera");
}

function function_a1d067908e206e63() {
  scripts\sp\equipment\offhands::overrideweaponoffhandtype("iw9_gunless", 0);
  level.player forceplaygestureviewmodel("iw8_vm_ges_ks_radio_ear_mp");
  wait 2;
  level thread function_f0c06553aac70bd1();
  showcinematicletterboxing(1, 0);
  flag_set("flg_park_transition_gesture_done");
  level thread namespace_85a51fd192b9a590::function_d4b414285f705106();
  namespace_492643300158dc9f::function_af8cc52dde1fec72();
  hidecinematicletterboxing(1, 0);
}

function function_f0c06553aac70bd1() {
  while(!flag("flg_park_transition_gesture_done")) {
    setomnvar("ui_out_of_bounds_countdown", 0);
    wait 0.1;
  }
}

function private function_dfee9368a79e1912() {
  if(getdvarint(@ "hash_c96167e2d3de211", 1)) {
    flag_wait("flg_rewind_target_entered_bistro");
    wait 3;

    if(!flag("flg_cctv_2_active")) {
      display_hint("cctv_cycle_camera_hint");
    }

    return;
  }

  flag_wait("flg_rewind_target_entered_bistro");

  if(!flag("flg_cctv_2_active")) {
    display_hint("cctv_cycle_camera_hint", 8, level, "flg_cctv_2_active");
  }
}

function function_cfb664cbc74d988() {
  return function_7848d30e8f60dcbb() || function_a9ed17acec4c73c();
}

function function_7848d30e8f60dcbb() {
  return level.player isps4player() || level.player isxb3player();
}

function function_a9ed17acec4c73c() {
  return level.player ispcplayer() && getdvarint(@ "hash_510d6cf1b6fec656", 0);
}

function function_a22b777baf43f737() {}

function private function_3fc0e08182d8d965() {
  level.player hidelegsandshadow();
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player.ignoreme = 1;

  if(!flag("cctv_init_done")) {
    function_cb758d1bffa656a0();
    level.var_91eb6136661c6756 = [];
  }

  if(!isDefined(level.current_cam)) {
    level.current_cam = level.cams[0];
  }

  level.previous_cam = level.current_cam;
  level.previous_cam hide();
  setomnvar("ui_cctv_active", 1);
  setomnvar("ui_cctv_camera_index", level.current_cam.var_efc49f91012daafc);
  setomnvar("ui_cctv_zone_index", level.current_cam.ui_cam_zone);
  motion_blur_disable();
  thread function_f4795bebba0ca2f2();

  thread function_5901e04fa0f276d6();
}

function function_d4aea2d3754a3b29() {}

function private function_cb758d1bffa656a0() {
  var_a78f42b6cd29929e = [360, 360, 20, 60];
  var_e3a3644bf212671e = [90, 90, 20, 60];
  var_749beb5407615099 = [45, 45, 20, 60];
  var_60708dd6eda5c8ac = [0, 0, 0, 0];
  level.cams = [];
  function_8866b8eb15dd9f70("s_street_cctv_1", 20, var_60708dd6eda5c8ac, getEnt("s_street_cctv_1", "script_noteworthy").origin + (0, 0, -50), getEnt("s_street_cctv_1", "script_noteworthy").angles);
  function_8866b8eb15dd9f70("s_street_cctv_2", 70, var_60708dd6eda5c8ac, getEnt("s_street_cctv_2", "script_noteworthy").origin + (0, 0, -50), getEnt("s_street_cctv_2", "script_noteworthy").angles);
  function_8866b8eb15dd9f70("s_street_cctv_3", 70, var_60708dd6eda5c8ac, getEnt("s_street_cctv_3", "script_noteworthy").origin + (0, 0, -50), getEnt("s_street_cctv_3", "script_noteworthy").angles);
  function_8866b8eb15dd9f70("s_street_cctv_4", 70, var_60708dd6eda5c8ac, getEnt("s_street_cctv_4", "script_noteworthy").origin + (0, 0, -50), getEnt("s_street_cctv_4", "script_noteworthy").angles);
  function_8866b8eb15dd9f70("s_street_cctv_5", 70, var_60708dd6eda5c8ac, getEnt("s_street_cctv_5", "script_noteworthy").origin + (0, 0, -50), getEnt("s_street_cctv_5", "script_noteworthy").angles);
  function_8866b8eb15dd9f70("s_street_cctv_6", 70, var_60708dd6eda5c8ac, getEnt("s_street_cctv_6", "script_noteworthy").origin + (0, 0, -50), getEnt("s_street_cctv_6", "script_noteworthy").angles);
  function_8866b8eb15dd9f70("s_street_cctv_7", 70, var_60708dd6eda5c8ac, getEnt("s_street_cctv_7", "script_noteworthy").origin + (0, 0, -50), getEnt("s_street_cctv_7", "script_noteworthy").angles);

  foreach(cam in level.cams) {
    cam function_88752e4eabb4c658();
  }

  if(isDefined(level.start_cam) && level.start_cam == 0) {
    level.current_cam = level.cams["s_street_cctv_1"];
    return;
  }

  if(isDefined(level.start_cam) && level.start_cam == 1) {
    level.current_cam = level.cams["s_street_cctv_2"];
    return;
  }

  if(isDefined(level.start_cam) && level.start_cam == 2) {
    level.current_cam = level.cams["s_street_cctv_3"];
    return;
  }

  if(isDefined(level.start_cam) && level.start_cam == 3) {
    level.current_cam = level.cams["s_street_cctv_4"];
    return;
  }

  if(isDefined(level.start_cam) && level.start_cam == 4) {
    level.current_cam = level.cams["s_street_cctv_5"];
    return;
  }

  if(isDefined(level.start_cam) && level.start_cam == 5) {
    level.current_cam = level.cams["s_street_cctv_6"];
    return;
  }

  if(isDefined(level.start_cam) && level.start_cam == 6) {
    level.current_cam = level.cams["s_street_cctv_7"];
  }
}

function private function_8866b8eb15dd9f70(cam_name, starting_zoom, view_arcs, player_anchor_origin, player_anchor_angle) {
  if(!isDefined(starting_zoom)) {
    starting_zoom = 70;
  }

  if(!isDefined(player_anchor_origin)) {
    player_anchor_origin = undefined;
  }

  if(!isDefined(player_anchor_angle)) {
    player_anchor_angle = undefined;
  }

  new_cam = [];
  new_cam["cam_name"] = cam_name;
  new_cam["starting_zoom"] = starting_zoom;
  new_cam["view_arcs"] = view_arcs;
  new_cam["player_anchor_origin"] = player_anchor_origin;
  new_cam["player_anchor_angle"] = player_anchor_angle;
  level.cams[new_cam["cam_name"]] = function_63c8b8d28f1cf55a(new_cam);

  if(flag("cctv_init_done")) {
    level.cams[new_cam["cam_name"]] function_88752e4eabb4c658();
  }
}

function private function_63c8b8d28f1cf55a(var_20ffe62a3b87f07f) {
  cam = getEnt(var_20ffe62a3b87f07f["cam_name"], "script_noteworthy");

  if(!isDefined(cam)) {
    assertmsg("Camera " + var_20ffe62a3b87f07f["cam_name"] + " is undefined. Was script noteworthy set correctly?");
    return undefined;
  }

  cam.cam_name = var_20ffe62a3b87f07f["cam_name"];
  cam.player_anchor = spawnStruct();
  cam hide();

  if(isDefined(var_20ffe62a3b87f07f["player_anchor_origin"])) {
    cam.player_anchor.origin = var_20ffe62a3b87f07f["player_anchor_origin"];
  } else {
    cam.player_anchor.origin = cam.origin;
  }

  if(isDefined(var_20ffe62a3b87f07f["player_anchor_angle"])) {
    cam.player_anchor.angles = var_20ffe62a3b87f07f["player_anchor_angle"];
  } else {
    cam.player_anchor.angles = cam.angles;
  }

  cam.player_anchor = spawn_tag_origin(cam.player_anchor.origin, cam.player_anchor.angles);
  cam.view_arcs = var_20ffe62a3b87f07f["view_arcs"];
  cam function_523231b88c6410e5();
  cam.fov = ter_op(isDefined(var_20ffe62a3b87f07f["starting_zoom"]), var_20ffe62a3b87f07f["starting_zoom"], 70);
  return cam;
}

function private function_88752e4eabb4c658() {
  self.var_4f0d076b113c5ea3 = [];

  if(isDefined(self.script_linkto)) {
    var_77a2516926152062 = strtoksubstr(self.script_linkto, " ");
  }

  foreach(cam in level.cams) {
    var_e72bcdb7a38e8446 = 0;
    var_fed9b28038493c02 = 0;

    if(isDefined(self.script_linkto) && isDefined(cam.script_linkname)) {
      var_fed9b28038493c02 = issubstr(self.script_linkto, cam.script_linkname);
    }

    if(cam != self && (var_e72bcdb7a38e8446 || var_fed9b28038493c02)) {
      for(i = 0; i < var_77a2516926152062.size; i++) {
        if(issubstr(var_77a2516926152062[i], cam.script_linkname)) {
          self.var_4f0d076b113c5ea3[i] = cam;
        }

        if(issubstr(var_77a2516926152062[i], "null_cam")) {
          self.var_4f0d076b113c5ea3[i] = "link_cam_override";
        }
      }
    }
  }
}

function private cctv_camera_look_speed(enabled) {
  if(enabled) {
    if(is_player_gamepad_enabled()) {
      self enableslowaim(0.4, 0.2);
      self capturnrate(0, 0);
    } else {
      self enableslowaim(0.6, 0.4);
      self capturnrate(0, 0);
    }

    return;
  }

  self disableslowaim();
  self capturnrate(0, 0);
}

function private securitycam_slow_look() {
  while(!flag("cctv_end")) {
    wait 1;
    level.player cctv_camera_look_speed(1);
    waitframe();
  }

  level.player cctv_camera_look_speed(0);
}

function function_5837f602f6be6f31() {}

function private function_523231b88c6410e5() {
  switch (self.script_noteworthy) {
    case #"hash_e4c7957ca86ffa89":
      self.var_efc49f91012daafc = 1;
      self.ui_cam_zone = 1;
      break;
    case #"hash_e4c7927ca86ff5d0":
      self.var_efc49f91012daafc = 3;
      self.ui_cam_zone = 2;
      break;
    case #"hash_e4c7937ca86ff763":
      self.var_efc49f91012daafc = 3;
      self.ui_cam_zone = 3;
      break;
    case #"hash_e4c7987ca86fff42":
      self.var_efc49f91012daafc = 3;
      self.ui_cam_zone = 4;
      break;
    case #"hash_e4c7997ca87000d5":
      self.var_efc49f91012daafc = 3;
      self.ui_cam_zone = 5;
      break;
    case #"hash_e4c7967ca86ffc1c":
      self.var_efc49f91012daafc = 3;
      self.ui_cam_zone = 6;
      break;
    case #"hash_e4c7977ca86ffdaf":
      self.var_efc49f91012daafc = 2;
      self.ui_cam_zone = 7;
      break;
    default:
      if(isDefined(self.script_noteworthy)) {
        assertmsg("The Camera, " + self.script_noteworthy + " does not have a proper case setup.");
        self.var_efc49f91012daafc = 0;
        self.ui_cam_zone = 1;
      } else {
        assertmsg("A camera is missing necessary identification. is your script_noteworthy correctly set?");
      }

      break;
  }
}

function function_50bce9b3edba0a5b() {
  cctv_camera_overlay();
  visionsetnaked("", 0.5);
  level.player modifybasefov(65);
}

function cctv_camera_overlay() {
  self.overlay = newclienthudelem(level.player);
  self.overlay.sort = 0;
  self.overlay.foreground = 0;
  self.overlay.lowresbackground = 1;
  self.overlay.horzalign = "fullscreen";
  self.overlay.vertalign = "fullscreen";
  self.overlay.alpha = 1;
  self.overlay.enablehudlighting = 1;
  self.overlay setshader("ui_bomber_drone_overlay", 640, 480);
  flag_wait("cctv_end");
  self.overlay destroy();
}

function private function_ae0d80a4899b77e0() {
  array_thread(level.cams, &function_1ec32b1cdddb9146);
  array_thread(level.cams, &function_2d0546014afd82b8);
}

function private function_9246006fb1dba7d4() {
  if(!isDefined(self.var_414b9a0d57c1e081)) {
    return 0;
  }

  array_thread(level.previous_cam.var_4f0d076b113c5ea3, &function_2d0546014afd82b8);

  foreach(cam in level.cams) {
    level.player function_aae81ea024d45e77(cam, "node");
  }
}

function private function_2d0546014afd82b8() {
  if(isstring(self) && self == "link_cam_override") {
    return;
  }

  if(isDefined(self) && level.player function_b76083c9909e209a(self, "node")) {
    function_46c43adbed209eaa(self, "DefaultSequence");
  }
}

function private function_1ec32b1cdddb9146() {
  level.player function_2acd5041c3f3305e(self, "node", "scripted_widget_movement_node", "scripted_widget_anchor_camera_node");
  self.anim_state = "";
  function_46c43adbed209eaa(self, "DefaultSequence");
}

function private function_344c564e0f6935e4() {
  foreach(trigger in level.var_2a1499facf0d3e69) {
    trigger.hint_ent delete();
  }
}

function private function_cb434bd8c2a84c66() {
  if(flag("cctv_clear_ui")) {
    return;
  }

  flag_set("cctv_clear_ui");
  function_9246006fb1dba7d4();
  function_344c564e0f6935e4();
}

function private function_d36af408e1a66d8c(time, var_b6b32ad0abab8814, flg_end) {
  level.player endon("death");
  level endon("cctv_face_scan_success");
  level endon("cctv_face_scan_fail");
  hud1 = newhudelem();
  hud1.alignx = "center";
  hud1.aligny = "middle";
  hud1.fontscale = 2.5;
  hud1.x = 330;
  hud1.y = 36;
  hud1 settext("<<< SCAN FACE DATA >>>");
  hud2 = newhudelem();
  hud2.alignx = "left";
  hud2.aligny = "middle";
  hud2.fontscale = 3;
  hud2.x = 210;
  hud2.y = 58;
  hud2.color = (0, 1, 0);
  var_3d3e99385c5f4a0f = 0;
  var_3e3fee18bb4afc95 = "";

  while(!flag(flg_end)) {
    if(flag("cctv_look_at_scan_target")) {
      level waittill("cctv_scanning");
      var_3e3fee18bb4afc95 += "=";

      if(!flag("flg_face_scan_started")) {
        flag_set("flg_face_scan_started");
      }

      hud2 settext(var_3e3fee18bb4afc95);
      time -= 1;
    }

    waitframe();

    if(time <= 0) {
      var_3d3e99385c5f4a0f = 1;
      break;
    }
  }

  if(var_3d3e99385c5f4a0f) {
    hud1.color = (0, 1, 0);
    hud1 settext("<<< SCAN COMPLETE >>>");
    wait 1;
    hud1 destroy();
    hud2 destroy();

    if(isDefined(var_b6b32ad0abab8814)) {
      flag_set(var_b6b32ad0abab8814);
    }

    level notify("cctv_face_scan_success");
    return;
  }

  hud1.color = (1, 0, 0);
  hud1 settext("<<< SCAN FAILED >>>");
  wait 1;
  hud1 destroy();
  hud2 destroy();
  level notify("cctv_face_scan_fail");
}

function function_6d5a8f3839fbf885() {
  level.player endon("death");
  hud1 = newhudelem();
  hud1.alignx = "center";
  hud1.aligny = "middle";
  hud1.fontscale = 5;
  hud1.x = 300;
  hud1.y = 40;
  hud1 settext("");
  hud2 = newhudelem();
  hud2.alignx = "left";
  hud2.aligny = "middle";
  hud2.fontscale = 5;
  hud2.x = 330;
  hud2.y = 40;
  hud2 settext("");
  var_3d3e99385c5f4a0f = 0;
  var_e11a4ce62f411dfe = 3;
  var_901108611d3c969a = 0;
  thread function_81db82a19ca05bf(var_e11a4ce62f411dfe);
  level.player playSound("surg_cctv_static_3sec");

  while(var_901108611d3c969a < var_e11a4ce62f411dfe) {
    hud2 settext("");
    wait 1;
    var_901108611d3c969a += 1;
    hud2 settext("");
    wait 1;
    var_901108611d3c969a += 1;
    hud2 settext("");
    wait 1;
    var_901108611d3c969a += 1;
  }

  hud1 destroy();
  hud2 destroy();
}

function private function_1420031998e0a6d1() {
  if(getdvarint(@ "hash_c96167e2d3de211", 1)) {
    display_hint("cctv_cycle_camera_hint");
    return;
  }

  display_hint("cctv_change_camera_hint");
}

function function_510c044704a2b63c() {}

function private function_2aaf51245e5ed210() {
  level endon("cctv_end");
  level.var_17739f9fbabb212f = undefined;
  thread function_1bed77c25c31079d();
  var_2e4db7ec2a289504 = [1, 1, 0];

  while(!flag("cctv_end")) {
    playereyepos = level.player getEye();
    var_6251ed2de10ae056[0] = function_acc162836243f997(playereyepos);
    var_6251ed2de10ae056[1] = function_c309de0bba0bbdd1(playereyepos);
    selectedtarget = undefined;
    var_a4c11efb8eaf47a4 = -1;

    for(i = 0; i < var_2e4db7ec2a289504.size; i++) {
      if(var_2e4db7ec2a289504[i] > var_a4c11efb8eaf47a4 && isDefined(var_6251ed2de10ae056[i])) {
        var_a4c11efb8eaf47a4 = var_2e4db7ec2a289504[i];
        selectedtarget = var_6251ed2de10ae056[i];
        continue;
      }

      if(var_2e4db7ec2a289504[i] == var_a4c11efb8eaf47a4 && isDefined(var_6251ed2de10ae056[i]) && selectedtarget.minangle > var_6251ed2de10ae056[i].minangle) {
        selectedtarget = var_6251ed2de10ae056[i];
      }
    }

    if(isDefined(selectedtarget)) {
      if(isDefined(selectedtarget.var_35c8ba6530ffe9d1)) {
        function_46c43adbed209eaa(selectedtarget.var_c644bde36f592421, selectedtarget.var_35c8ba6530ffe9d1);
      }

      level.var_17739f9fbabb212f = selectedtarget.var_c644bde36f592421;
    } else {
      level.var_17739f9fbabb212f = undefined;
    }

    waitframe();
  }
}

function private function_1bed77c25c31079d() {
  level endon("cctv_end");
  level.player notifyonplayercommand("cctv_scan_face", "+activate");
  level.player notifyonplayercommand("cctv_scan_face_pad", "+usereload");

  if(!getdvarint(@ "hash_c96167e2d3de211", 1)) {
    level.player notifyonplayercommand("select_camera", "+weapnext");
    level.player notifyonplayercommand("select_camera_pad", "+gostand");
  }

  while(!flag("cctv_end")) {
    var_c53b510d02b534e0 = level.player waittill_any_return("cctv_scan_face", "cctv_scan_face_pad", "select_camera_pad", "select_camera");

    if(flag("switching_camera")) {
      continue;
    }

    var_e6de0769c5ab908 = level.player usinggamepad();
    var_320b0044cca274fa = 0;

    if(isDefined(var_c53b510d02b534e0) && isDefined(level.var_17739f9fbabb212f)) {
      if(!issentient(level.var_17739f9fbabb212f) && isDefined(level.var_17739f9fbabb212f.var_4f0d076b113c5ea3) && (var_c53b510d02b534e0 == "select_camera" && var_e6de0769c5ab908 || var_c53b510d02b534e0 == "select_camera_pad" && !var_e6de0769c5ab908)) {
        if(!var_e6de0769c5ab908) {
          var_c53b510d02b534e0 = "select_camera";
        }

        var_320b0044cca274fa = 1;
      } else if(!issentient(level.var_17739f9fbabb212f) && (var_c53b510d02b534e0 == "cctv_scan_face_pad" && var_e6de0769c5ab908 || var_c53b510d02b534e0 == "cctv_scan_face" && !var_e6de0769c5ab908)) {
        var_c53b510d02b534e0 = "scan_camera";
        var_320b0044cca274fa = 1;
      }
    }

    if(var_320b0044cca274fa) {
      function_4ed615fbc027e51c(level.var_17739f9fbabb212f, var_c53b510d02b534e0);
      level.var_17739f9fbabb212f = undefined;
    }

    waitframe();
  }
}

function private function_4ed615fbc027e51c(var_17739f9fbabb212f, command) {
  if(flag("cctv_end")) {
    return;
  }

  if(command == "select_camera") {
    var_17739f9fbabb212f thread function_11671c2e250e9320();
    return;
  }

  if(command == "scan_camera") {
    var_17739f9fbabb212f thread function_4f27eb3418e0d9a4();
  }
}

function private function_c309de0bba0bbdd1(playereyepos) {
  var_2cc013fe3321739d = 0.992546;
  var_ed68dc64b00935cc = 7;
  var_4f4757f97e2026b1 = undefined;

  if(!flag("cctv_enable_camera")) {
    return;
  }

  if(!isDefined(level.current_cam.var_4f0d076b113c5ea3)) {
    return;
  }

  foreach(cam in level.current_cam.var_4f0d076b113c5ea3) {
    if(isstring(cam) && cam == "link_cam_override") {
      continue;
    }

    if(!getdvarint(@ "hash_c96167e2d3de211", 1)) {
      campos = cam.origin;

      if(player_looking_at(campos, var_2cc013fe3321739d, undefined, [level.current_cam, cam])) {
        angle = math::anglebetweenvectors(anglesToForward(level.player getplayerangles()), vectorNormalize(campos - playereyepos));

        if(angle < var_ed68dc64b00935cc) {
          if(!isDefined(var_4f4757f97e2026b1)) {
            var_4f4757f97e2026b1 = spawnStruct();
          }

          var_ed68dc64b00935cc = angle;
          var_4f4757f97e2026b1.var_c644bde36f592421 = cam;
          var_4f4757f97e2026b1.minangle = angle;
          var_4f4757f97e2026b1.var_35c8ba6530ffe9d1 = "CameraNodeInteract";
        }
      }
    }

    function_46c43adbed209eaa(cam, "CameraNode");
  }

  return var_4f4757f97e2026b1;
}

function private function_46c43adbed209eaa(node, state) {
  if(isDefined(node) && isDefined(node.anim_state) && node.anim_state != state) {
    node.anim_state = state;
    level.player function_d28fa5295a04d555("node" + node getentitynumber(), state);
  }
}

function function_81ca825f6d3cb5d8() {}

function private function_acc162836243f997(playereyepos) {
  var_a6aa99d338d44d29 = 0.766044;
  var_72a28ce10d17caf4 = 6;
  var_4f4757f97e2026b1 = undefined;

  foreach(scan_ent in level.var_91eb6136661c6756) {
    nodepos = scan_ent.origin;

    if(isDefined(level.var_7d7f0b9f883c729c) && isDefined(scan_ent.var_393dd251907fc96a) && isDefined(scan_ent.var_4317a8168758d17d)) {
      if(level.var_7d7f0b9f883c729c <= scan_ent.var_4317a8168758d17d && level.var_7d7f0b9f883c729c >= scan_ent.var_393dd251907fc96a) {
        function_46c43adbed209eaa(scan_ent, "IconBomb");
      } else {
        function_46c43adbed209eaa(scan_ent, "DefaultSequence");
        flag_clear("cctv_look_at_scan_target");
        continue;
      }
    }

    if(player_looking_at(nodepos, var_a6aa99d338d44d29, undefined, level.current_cam)) {
      angle = anglebetweenvectors(anglesToForward(level.player getplayerangles()), vectorNormalize(nodepos - playereyepos));

      if(angle < var_72a28ce10d17caf4 && level.current_cam.fov <= 30) {
        if(!isDefined(var_4f4757f97e2026b1)) {
          var_4f4757f97e2026b1 = spawnStruct();
        }

        var_72a28ce10d17caf4 = angle;
        var_4f4757f97e2026b1.var_c644bde36f592421 = scan_ent;
        var_4f4757f97e2026b1.minangle = angle;
        var_4f4757f97e2026b1.var_35c8ba6530ffe9d1 = "Prompt";
        flag_set("cctv_look_at_scan_target");
      } else {
        flag_clear("cctv_look_at_scan_target");
        level notify("cctv_scan_target_lost");
      }

      function_46c43adbed209eaa(scan_ent, "IconBomb");
      continue;
    }

    function_46c43adbed209eaa(scan_ent, "DefaultSequence");
    flag_clear("cctv_look_at_scan_target");
  }

  return var_4f4757f97e2026b1;
}

function function_29a23ca2e3821f1e(var_94bbe94014394d5b, var_276ef4838c7c89d, var_9d82d90af983df46, var_75c4321edc25685e, var_393dd251907fc96a, var_4317a8168758d17d, var_c1978323e243becf) {
  if(!isDefined(var_276ef4838c7c89d)) {
    var_276ef4838c7c89d = 9;
  }

  if(!isDefined(var_75c4321edc25685e)) {
    var_75c4321edc25685e = "cctv_face_scan_end";
  }

  if(!isDefined(var_c1978323e243becf)) {
    var_c1978323e243becf = 1;
  }

  var_b0ef27a1b00a23b2 = spawn("script_origin", var_94bbe94014394d5b);
  var_b0ef27a1b00a23b2.hint_ent = spawn("script_model", var_b0ef27a1b00a23b2.origin);
  var_b0ef27a1b00a23b2.hint_ent setModel("tag_origin");
  var_b0ef27a1b00a23b2.hint_ent.node_ref = var_b0ef27a1b00a23b2;
  level.player function_2acd5041c3f3305e(var_b0ef27a1b00a23b2.hint_ent, "node", "scripted_widget_cctv_interact", "scripted_widget_anchor_camera_node");
  var_b0ef27a1b00a23b2.hint_ent.anim_state = "";
  function_46c43adbed209eaa(var_b0ef27a1b00a23b2.hint_ent, "IconBomb");

  if(isDefined(var_393dd251907fc96a) && isDefined(var_4317a8168758d17d)) {
    var_b0ef27a1b00a23b2.hint_ent.var_393dd251907fc96a = var_393dd251907fc96a;
    var_b0ef27a1b00a23b2.hint_ent.var_4317a8168758d17d = var_4317a8168758d17d;
  }

  level.var_91eb6136661c6756 = array_add(level.var_91eb6136661c6756, var_b0ef27a1b00a23b2.hint_ent);
  level thread function_d36af408e1a66d8c(var_276ef4838c7c89d, var_9d82d90af983df46, var_75c4321edc25685e);
  var_3a65b78c0880403a = ["cctv_scan_hint_remove", "cctv_end", var_9d82d90af983df46];

  if(var_c1978323e243becf) {
    if(getdvarint(@ "hash_c0009c0cc6d51808", 1)) {
      display_hint("<dev string:x1c>", undefined, undefined, level, var_3a65b78c0880403a);
    } else {
      display_hint("<dev string:x1c>", 4);
    }
  }

  level waittill_either("cctv_face_scan_success", "cctv_face_scan_fail");
  level.var_91eb6136661c6756 = array_remove(level.var_91eb6136661c6756, var_b0ef27a1b00a23b2.hint_ent);
  var_b0ef27a1b00a23b2.hint_ent delete();
  var_b0ef27a1b00a23b2 delete();
}

function function_cd6ebb4e3724ac77() {
  foreach(scan_ent in level.var_91eb6136661c6756) {
    scan_ent delete();
  }
}

function private function_4f27eb3418e0d9a4() {
  level.player endon("cctv_stop_scan_face");
  level endon("cctv_scan_target_lost");
  level endon("cctv_face_scan_success");
  var_e6de0769c5ab908 = level.player usinggamepad();

  if(var_e6de0769c5ab908) {
    level.player notifyonplayercommand("cctv_stop_scan_face", "-usereload");
  } else {
    level.player notifyonplayercommand("cctv_stop_scan_face", "-activate");
  }

  while(true) {
    if(flag("cctv_look_at_scan_target")) {
      level notify("cctv_scanning");
    }

    wait 1;
  }
}

function function_9e2b10c4b3e77b13() {}

function function_11671c2e250e9320() {
  if(isDefined(level.current_cam) && level.current_cam == self || flag("cctv_end")) {
    return;
  }

  flag_set("switching_camera");
  level.player playSound("surge_cctv_start");
  level notify("cam_switch");
  level.player notify("cam_switch");

  if(!flag("cctv_first_cam_switch")) {
    flag_set("cctv_first_cam_switch");
  }

  level.player setclientomnvar("ui_hide_hud", 1);
  function_64196226b4e5c384();
  setomnvar("ui_cctv_camera_index", self.var_efc49f91012daafc);
  setomnvar("ui_cctv_zone_index", self.ui_cam_zone);
  level.previous_cam.last_angles = level.player getplayerangles();
  level.previous_cam = level.current_cam;
  level.previous_cam show();
  level.current_cam = self;
  self hide();

  foreach(cam in level.previous_cam.var_4f0d076b113c5ea3) {
    if(isstring(cam) && cam == "link_cam_override") {
      continue;
    }

    cam function_2d0546014afd82b8();
  }

  function_3bca028b81b9315();
  wait 0.15;
  waitframe();
  level.player setclientomnvar("ui_hide_hud", 0);
  thread function_df92850503fdbc8b();
  wait 1.2;
  flag_clear("switching_camera");
  level notify("finished_cam_switch");
  level notify("switched_to_" + level.current_cam.script_noteworthy);
}

function private function_df92850503fdbc8b() {
  if(!flag("switched_to_" + level.current_cam.script_noteworthy)) {
    flag_set("switched_to_" + level.current_cam.script_noteworthy);

    switch (level.current_cam.script_noteworthy) {
      case #"hash_e4c7957ca86ffa89":
        setomnvar("ui_cctv_camera_index", 0);
        level.player playSound("surg_cctv_static_1sec");
        flag_set("flg_cctv_1_active_first");
        flag_set("CCTV_zoom_disabled");
        array_thread(level.current_cam.var_4f0d076b113c5ea3, &function_2d0546014afd82b8);
        level.current_cam.var_4f0d076b113c5ea3 = [];
        wait 2;
        var_215c491624c432aa = level.player spawn_script_origin();
        var_215c491624c432aa playLoopSound("surg_cctv_zoom_out");
        change_amt = 2;
        var_97ccc1b76a109642 = 0.1;
        change_speed = 1;

        while(true) {
          level.current_cam.fov = clamp(level.current_cam.fov + change_amt * change_speed, 20, 70);
          level.player modifybasefov(level.current_cam.fov, var_97ccc1b76a109642);
          level.player setclientomnvar("ui_killstreak_zoom_fov", level.current_cam.fov);

          if(level.current_cam.fov == 70) {
            var_215c491624c432aa stoploopsound("surg_cctv_zoom_out");
            var_215c491624c432aa delete();
            wait 1;
            flag_clear("CCTV_zoom_disabled");
            break;
          }

          waitframe();
        }

        flag_wait("flg_rewind_target_entered_bistro");
        level.current_cam function_88752e4eabb4c658();
        setomnvar("ui_cctv_camera_index", 1);
        break;
      case #"hash_e4c7927ca86ff5d0":
        level.player playSound("surg_cctv_static_025sec");
        break;
      case #"hash_e4c7937ca86ff763":
        level.player playSound("surg_cctv_static_025sec");
        break;
      case #"hash_e4c7987ca86fff42":
        level.player playSound("surg_cctv_static_025sec");
        break;
      case #"hash_e4c7997ca87000d5":
        level.player playSound("surg_cctv_static_025sec");
        break;
      case #"hash_e4c7967ca86ffc1c":
        level.player playSound("surg_cctv_static_025sec");
        break;
      case #"hash_e4c7977ca86ffdaf":
        level.player playSound("surg_cctv_static_025sec");
        break;
    }
  }
}

function private function_64196226b4e5c384() {
  switch (level.current_cam.script_noteworthy) {
    case #"hash_e4c7957ca86ffa89":
      if(!flag("flg_cctv_1_active")) {
        thread function_81db82a19ca05bf(1);
      } else {
        thread function_81db82a19ca05bf(0.25);
      }

      break;
    case #"hash_e4c7927ca86ff5d0":
      thread function_81db82a19ca05bf(0.25);
      break;
    case #"hash_e4c7937ca86ff763":
      thread function_81db82a19ca05bf(0.25);
      break;
    case #"hash_e4c7987ca86fff42":
      thread function_81db82a19ca05bf(0.25);
      break;
    case #"hash_e4c7997ca87000d5":
      thread function_81db82a19ca05bf(0.25);
      break;
    case #"hash_e4c7967ca86ffc1c":
      thread function_81db82a19ca05bf(0.25);
      break;
    case #"hash_e4c7977ca86ffdaf":
      thread function_81db82a19ca05bf(0.25);
      break;
  }
}

function function_81db82a19ca05bf(var_ff1b0cfc5ebb5665) {
  visionsetnaked("taccam_static_full", 0.7);
  wait var_ff1b0cfc5ebb5665;
  visionsetnaked("sp_jup_surge_camera_cctv2", 0.1);
}

function private function_3bca028b81b9315(var_b18cac93c61c669e) {
  level.player unlink();
  level.player dontinterpolate();
  level.player setOrigin(self.player_anchor.origin);
  level.player playerlinktodelta(self.player_anchor, "tag_origin", 1, self.view_arcs[0], self.view_arcs[1], self.view_arcs[2], self.view_arcs[3], 0);

  if(isDefined(level.var_c900db68646b554e) && cantracetoai(level.var_c900db68646b554e, level.player getEye(), [self], create_default_contents()) && distance(level.var_c900db68646b554e.origin, self.origin) <= 1800) {
    function_9992b2755a08da84(0.98, 0.99);
  } else {
    level.player setplayerangles(self.player_anchor.angles);
  }

  if(istrue(var_b18cac93c61c669e)) {
    level.player modifybasefov(level.current_cam.fov, 0.2);
    level.player setclientomnvar("ui_killstreak_zoom_fov", level.current_cam.fov);
  } else {
    level.player modifybasefov(level.current_cam.fov);
    level.player setclientomnvar("ui_killstreak_zoom_fov", level.current_cam.fov);
  }

  level.player thread cctv_camera_look_speed(1);
}

function private function_9992b2755a08da84(force_min, force_max) {
  if(!isDefined(force_min)) {
    force_min = 0;
  } else {
    clamp(force_min, 0, 1);
  }

  if(!isDefined(force_max)) {
    force_max = 1;
  } else {
    clamp(force_max, 0, 1);
  }

  force = randomfloatrange(force_min, force_max);
  var_934dca77580f34aa = self.angles[1];
  var_1085cf80ee34bfb6 = vectortoangles(level.var_c900db68646b554e gettagorigin("j_spine4") - self.origin);
  var_91324a24b0c8049d = var_1085cf80ee34bfb6[1] - var_934dca77580f34aa;
  level.player setplayerangles((var_1085cf80ee34bfb6[0], var_934dca77580f34aa + var_91324a24b0c8049d * force, var_1085cf80ee34bfb6[2]));
}

function private function_f2cd217859497020(next_cam, previous_cam) {
  level.player clearpredictedstreampos();
  level.player clearadditionalstreampos();

  if(isDefined(next_cam)) {
    level.player predictstreamposuntilcleared(next_cam.origin);
  }

  if(isDefined(previous_cam)) {
    level.player setadditionalstreamposuntilcleared(previous_cam.origin);
  }

  if(!isDefined(next_cam) && !isDefined(previous_cam)) {
    return;
  }
}

function private function_59eff5033ed73dd0() {
  level endon("cctv_end");

  while(true) {
    level waittill("cam_switch");

    if(isDefined(level.current_cam.var_4f0d076b113c5ea3[1]) && !isstring(level.current_cam.var_4f0d076b113c5ea3[1])) {
      function_f2cd217859497020(level.current_cam.var_4f0d076b113c5ea3[1], level.previous_cam);
    } else if(isDefined(level.current_cam.var_4f0d076b113c5ea3[0]) && level.current_cam.var_4f0d076b113c5ea3.size == 1 && !isstring(level.current_cam.var_4f0d076b113c5ea3[0])) {
      function_f2cd217859497020(level.current_cam.var_4f0d076b113c5ea3[0], level.previous_cam);
    } else if(isDefined(level.current_cam.var_4f0d076b113c5ea3[0]) && level.current_cam.var_4f0d076b113c5ea3.size != 1 && !isstring(level.current_cam.var_4f0d076b113c5ea3[0])) {
      function_f2cd217859497020(level.current_cam.var_4f0d076b113c5ea3[0], level.previous_cam);
    }

    waitframe();
  }
}

function function_9a8d0ad68ab8e7fc() {}

function private function_f4795bebba0ca2f2() {
  level endon("cctv_end");
  change_rate = 3;
  var_97ccc1b76a109642 = 0.1;
  level thread namespace_85a51fd192b9a590::function_ad005b37ad2132c0();

  while(true) {
    current_input = level.player getleftsticky();

    if(current_input != 0 && !flag("CCTV_rewind_active") && !flag("CCTV_zoom_disabled")) {
      level.current_cam.fov = clamp(level.current_cam.fov - change_rate * current_input, 20, 70);
      level.player modifybasefov(level.current_cam.fov, var_97ccc1b76a109642);
      level.player setclientomnvar("ui_killstreak_zoom_fov", level.current_cam.fov);
    }

    waitframe();
  }
}

function function_138f63339a6b7524() {}

function private function_7a2e20471c45d91b() {
  level endon("cctv_end");
  level.player notifyonplayercommand("cycle_camera_forward", "+frag");
  level.player notifyonplayercommand("cycle_camera_back", "+smoke");

  while(!flag("cctv_end")) {
    switch (level.current_cam.script_noteworthy) {
      case #"hash_e4c7957ca86ffa89":
        flag_clear("flg_cctv_2_active");
        flag_clear("flg_cctv_3_active");
        flag_clear("flg_cctv_4_active");
        flag_clear("flg_cctv_5_active");
        flag_clear("flg_cctv_6_active");
        flag_clear("flg_cctv_7_active");
        flag_set("flg_cctv_1_active");
        break;
      case #"hash_e4c7927ca86ff5d0":
        flag_clear("flg_cctv_1_active");
        flag_clear("flg_cctv_3_active");
        flag_clear("flg_cctv_4_active");
        flag_clear("flg_cctv_5_active");
        flag_clear("flg_cctv_6_active");
        flag_clear("flg_cctv_7_active");
        flag_set("flg_cctv_2_active");
        break;
      case #"hash_e4c7937ca86ff763":
        flag_clear("flg_cctv_1_active");
        flag_clear("flg_cctv_2_active");
        flag_clear("flg_cctv_4_active");
        flag_clear("flg_cctv_5_active");
        flag_clear("flg_cctv_6_active");
        flag_clear("flg_cctv_7_active");
        flag_set("flg_cctv_3_active");
        break;
      case #"hash_e4c7987ca86fff42":
        flag_clear("flg_cctv_1_active");
        flag_clear("flg_cctv_2_active");
        flag_clear("flg_cctv_3_active");
        flag_clear("flg_cctv_5_active");
        flag_clear("flg_cctv_6_active");
        flag_clear("flg_cctv_7_active");
        flag_set("flg_cctv_4_active");
        break;
      case #"hash_e4c7997ca87000d5":
        flag_clear("flg_cctv_1_active");
        flag_clear("flg_cctv_2_active");
        flag_clear("flg_cctv_3_active");
        flag_clear("flg_cctv_4_active");
        flag_clear("flg_cctv_6_active");
        flag_clear("flg_cctv_7_active");
        flag_set("flg_cctv_5_active");
        break;
      case #"hash_e4c7967ca86ffc1c":
        flag_clear("flg_cctv_1_active");
        flag_clear("flg_cctv_2_active");
        flag_clear("flg_cctv_3_active");
        flag_clear("flg_cctv_4_active");
        flag_clear("flg_cctv_5_active");
        flag_clear("flg_cctv_7_active");
        flag_set("flg_cctv_6_active");
        break;
      case #"hash_e4c7977ca86ffdaf":
        flag_clear("flg_cctv_1_active");
        flag_clear("flg_cctv_2_active");
        flag_clear("flg_cctv_3_active");
        flag_clear("flg_cctv_4_active");
        flag_clear("flg_cctv_5_active");
        flag_clear("flg_cctv_6_active");
        flag_set("flg_cctv_7_active");
        break;
    }

    var_c53b510d02b534e0 = level.player waittill_any_return("cycle_camera_forward", "cycle_camera_back");

    if(isDefined(var_c53b510d02b534e0)) {
      if(flag("switching_camera") || flag("CCTV_rewind_active")) {
        waitframe();
        continue;
      }

      if(var_c53b510d02b534e0 == "cycle_camera_forward" && isDefined(level.current_cam.var_4f0d076b113c5ea3[1]) && !isstring(level.current_cam.var_4f0d076b113c5ea3[1])) {
        function_f2cd217859497020(level.current_cam.var_4f0d076b113c5ea3[1], level.current_cam);
        level.current_cam.var_4f0d076b113c5ea3[1] thread function_11671c2e250e9320();
        continue;
      }

      if(var_c53b510d02b534e0 == "cycle_camera_forward" && isDefined(level.current_cam.var_4f0d076b113c5ea3[0]) && level.current_cam.var_4f0d076b113c5ea3.size == 1 && !isstring(level.current_cam.var_4f0d076b113c5ea3[0])) {
        function_f2cd217859497020(level.current_cam.var_4f0d076b113c5ea3[0], level.current_cam);
        level.current_cam.var_4f0d076b113c5ea3[0] thread function_11671c2e250e9320();
        continue;
      }

      if(var_c53b510d02b534e0 == "cycle_camera_back" && isDefined(level.current_cam.var_4f0d076b113c5ea3[0]) && level.current_cam.var_4f0d076b113c5ea3.size != 1 && !isstring(level.current_cam.var_4f0d076b113c5ea3[0])) {
        function_f2cd217859497020(level.current_cam.var_4f0d076b113c5ea3[0], level.current_cam);
        level.current_cam.var_4f0d076b113c5ea3[0] thread function_11671c2e250e9320();
      }
    }
  }
}

function function_75f50b4ab72d4125() {}

function function_ac5afa5a1415f2af(var_96f5e72338b5873) {
  setomnvar("ui_cctv_active", 0);
  blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  blackoverlay fadeovertime(0.05);
  blackoverlay.alpha = 1;
  wait 0.2;
  level.player clearpredictedstreampos();
  level.player clearadditionalstreampos();
  level.player unlink();
  level.player lerpfovscalefactor(1, 0);

  if(isDefined(var_96f5e72338b5873)) {
    level.player teleport_player(var_96f5e72338b5873);
  } else {
    level.player setOrigin(level.player.var_d5234a010d66e1a5);
    level.player setplayerangles(level.player.var_6de5fc8b2865186a);
  }

  level.player freezecontrols(1);
  flag_clear("cctv_enable_camera");
  flag_set("cctv_end");
  wait 0.05;
  blackoverlay fadeovertime(0.1);
  blackoverlay.alpha = 0;
  level.player clearsoundsubmix("surg_cctv_mix");
  level.player playSound("surge_cctv_stop");
  waitframe();
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player showlegsandshadow();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player.ignoreme = 0;
  level.player scripts\sp\player::allow_player_weapon_info(0);
  visionsetnaked("", 0.5);
  level.player thread cctv_camera_look_speed(0);
  level.player modifybasefov(65);
  function_9246006fb1dba7d4();
  setsaveddvar(@ "hash_7f682bcfe7bf6600", ter_op(isDefined(level.var_ce6c2a5a52b1fc4b), level.var_ce6c2a5a52b1fc4b, 100));
  level.player notifyonplayercommandremove("cctv_scan_face", "+activate");
  level.player notifyonplayercommandremove("cctv_scan_face_pad", "+usereload");
  level.player notifyonplayercommandremove("cycle_camera_forward", "+frag");
  level.player notifyonplayercommandremove("cycle_camera_back", "+smoke");
  level.player notifyonplayercommandremove("select_camera", "+weapnext");
  level.player notifyonplayercommandremove("select_camera_pad", "+gostand");
  level.player notifyonplayercommandremove("cctv_stop_scan_face", "-activate");
  level.player notifyonplayercommandremove("cctv_stop_scan_face", "-usereload");
  motion_blur_enable();
  waitframe();
}

function function_a9f48951eda527b2() {}

function function_5901e04fa0f276d6() {
  level.player endon("<dev string:x32>");
  level endon("<dev string:x38>");
  childthread function_5ec4e1a858403aeb();
  childthread function_5214acd431d3c8f2();
}

function private function_5ec4e1a858403aeb() {
  while(true) {
    if(getdvarfloat(@ "hash_f8078e31e611f1e6") == 1) {
      var_e955a13125a13269 = angleclamp(level.player getplayerangles(1)[1]);
      reference = level.current_cam.angles[1];
      printtoscreen2d(75, 225, "<dev string:x41>" + abs(abs(reference) - abs(var_e955a13125a13269)), (1, 1, 1), 3);
      printtoscreen2d(75, 275, "<dev string:x52>" + getdvarfloat(@ "cg_fov"), (1, 1, 1), 3);
      printtoscreen2d(75, 325, "<dev string:x68>" + level.current_cam.fov, (1, 1, 1), 3);
      printtoscreen2d(75, 375, level.current_cam.cam_name);
      printtoscreen2d(75, 425, "<dev string:x7e>" + level.current_cam.angles, (1, 1, 1), 3);
      printtoscreen2d(75, 475, "<dev string:x8b>" + level.current_cam.origin, (1, 1, 1), 3);
      printtoscreen2d(75, 525, "<dev string:x95>" + level.current_cam.var_4f0d076b113c5ea3.size, (1, 1, 1), 3);
    }

    waitframe();
  }
}

function private function_5214acd431d3c8f2() {
  while(true) {
    if(getdvarfloat(@ "hash_f8078e31e611f1e6") == 1) {
      foreach(cam in level.current_cam.var_4f0d076b113c5ea3) {
        if(isstring(cam) && cam == "<dev string:xab>") {
          continue;
        }

        color = (1, 0, 0);
        line(level.current_cam.origin, cam.origin, color, 1, 1);
      }
    }

    waitframe();
  }
}

# /