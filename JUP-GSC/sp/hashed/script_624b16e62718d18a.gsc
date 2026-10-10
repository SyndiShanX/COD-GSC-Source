/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_624b16e62718d18a.gsc
*************************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#namespace namespace_c07206719a9cb6d8;

function precache(offhand) {
  setdvarifuninitialized(@ "hash_3aca48795d467555", 0);
  level.scope_offhand = spawnStruct();
  level.scope_offhand.trace_contents = create_contents(1, 1, 0, 1, 1, 1, 0, 0, 1, 1);
  level.scope_offhand.in_use = 0;
  level.scope_offhand.used_once = 0;
  level.scope_offhand.var_c9b52c5429c64bba = 0;
  level.scope_offhand.instances = 0;
  level.scope_offhand.var_2616d3dd1d52992 = 1;
  level.scope_offhand.var_da2c3632fe97d9eb = 1;
  level.scope_offhand.var_9644508d9841f50a = 1;
  level.scope_offhand.laser_vfx = loadfx("vfx/iw8/level/lab/vfx_green_laser.vfx");
  registeroffhandfirefunc(offhand, &function_32f7b069ba153eaa);
  playeroffhandthread(&function_53402b702bd8e4ce);
  add_hint_string("offhand_spotter_detailed", &"EQUIPMENT/OFFHAND_SPOTTER_FULL");
  add_hint_string("offhand_spotter_simple", &"EQUIPMENT/OFFHAND_SPOTTER_SIMPLE", &function_75385c508a754a4b);
  add_hint_string("offhand_spotter_simple_press", &"EQUIPMENT/OFFHAND_SPOTTER_SIMPLE_PRESS", &function_75385c508a754a4b);
  add_hint_string("offhand_spotter_commit", &"EQUIPMENT/OFFHAND_SPOTTER_COMMIT", &function_77ff4092c0f2111c);
}

function function_32f7b069ba153eaa(grenade, weapon) {
  grenade delete();
}

function function_53402b702bd8e4ce() {
  ent_flag_init("spotter_scope_up");

  while(true) {
    self waittill("grenade_pullback", grenadeweapon);

    if(grenadeweapon.basename == "offhand_spotter_scope") {
      ent_flag_set("spotter_scope_up");
      self notify("spotter_scope_raised");
      level.scope_offhand.instances++;
      level.scope_offhand.in_use = 1;
      wait 0.45;

      if(function_f9bae891decd126a("offhand_spotter_scope")) {
        thread function_737973b91098b744();

        if(istrue(level.scope_offhand.var_2616d3dd1d52992)) {
          thread display_hint("offhand_spotter_commit", undefined, 0, [level.player], ["spotter_scope_away"]);
        }

        setomnvar("ui_spotter_scope_toggle_visibility", 1);
        function_89c8024ac9f37744();
        setomnvar("ui_spotter_scope_toggle_visibility", 0);
      }

      self notify("spotter_scope_away");
      ent_flag_clear("spotter_scope_up");
      level.scope_offhand.in_use = 0;
    }
  }
}

function function_89c8024ac9f37744() {
  self endon("weapon_switch_pressed");

  while(function_f9bae891decd126a("offhand_spotter_scope")) {
    waitframe();
  }
}

function spotter_commit() {
  if(!level.player fragButtonPressed() && !level.player function_61c258eacee448b2()) {
    return;
  }

  if(!level.scope_offhand.used_once) {
    level.scope_offhand.used_once = 1;
  }

  ignorearray = array_add(getaiarray("allies"), level.player);

  if(isDefined(level.var_d53e9074f5864705)) {
    ignorearray = array_combine(ignorearray, level.var_d53e9074f5864705);
  }

  trace = ray_trace_detail(level.player getEye(), level.player getEye() + anglesToForward(level.player getplayerangles()) * 49999, ignorearray, level.scope_offhand.trace_contents, 1);

  if(getdvarint(@ "hash_3aca48795d467555")) {
    thread scripts\engine\trace::draw_trace(trace, undefined, 1, 60);
  }

  level notify("spotter_scope_target", trace);
  level.scope_offhand.var_c9b52c5429c64bba = gettime();

  if(level.scope_offhand.var_da2c3632fe97d9eb) {
    level.player playSound("laze_ready");
  }

  if(level.scope_offhand.var_9644508d9841f50a) {
    level.player playRumbleOnEntity("damage_light");
  }
}

function function_cf2ade74ef2ec215(enabled) {
  assertex(isDefined(level.scope_offhand), "Trying to enable sounds on a spotter scope that was not properly spawned!");
  assert(isDefined(enabled));
  level.scope_offhand.var_da2c3632fe97d9eb = enabled;
}

function function_bf4b28ac990e07c4(enabled) {
  assertex(isDefined(level.scope_offhand), "Trying to enable sounds on a spotter scope that was not properly spawned!");
  assert(isDefined(enabled));
  level.scope_offhand.var_9644508d9841f50a = enabled;
}

function function_737973b91098b744() {
  self endon("spotter_scope_away");
  self endon("frag_released");

  while(true) {
    if(level.player usinggamepad()) {
      waittill_any_3("attack_pressed", "use_pressed", "melee_pressed");
    } else {
      self waittill("attack_pressed");
    }

    level spotter_commit();
    wait 0.25;
  }
}

function function_5e36ac4c83ab2d85() {
  overlay = newhudelem();
  overlay.x = 320;
  overlay.y = 240;
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.alpha = 1;
  overlay.font = "objective";
  overlay.foreground = 1;
  overlay.fontscale = 1.2;
  overlay settext("+");
  return overlay;
}

function function_77371b0fea36d1() {
  assertex(!isDefined(self.lasertag), "Laser Tag getting created when one exists already!");
  self.var_33fd2e8ba5dc653d = spawn("script_model", self.origin + (0, 0, 0));
  self.var_33fd2e8ba5dc653d setModel("misc_vm_handheld_green_laser");
  temp = makeweapon("iw8_spotter_scope_ir");
  self.var_33fd2e8ba5dc653d setmoverlaserweapon(temp);
  self.var_33fd2e8ba5dc653d linktoplayerview(self, "TAG_ACCESSORY_LEFT", (0, 0, 0), (0, 0, 0), 1);
  self.var_33fd2e8ba5dc653d hide();
}

function function_75385c508a754a4b() {
  return level.scope_offhand.in_use;
}

function function_77ff4092c0f2111c() {
  return !level.scope_offhand.in_use;
}

function function_bce4bdd85e6b37d0() {
  return level.scope_offhand.used_once;
}

function function_e28969e964231be6() {
  time = gettime();

  while(level.scope_offhand.var_c9b52c5429c64bba < time) {
    waitframe();
  }
}

function function_e3ecad902b0ebce7() {
  return isDefined(level.player.offhandweapon) && is_equal(level.player.offhandweapon.basename, "offhand_spotter_scope");
}

function function_5499e027134652fc() {
  display_hint("offhand_spotter_detailed", undefined, undefined, level.player, "spotter_marked");
}

function function_7c5679320c7c1fac(endonmessage, timeout) {
  if(level.player function_61c258eacee448b2()) {
    display_hint("offhand_spotter_simple_press", timeout, undefined, level.player, endonmessage);
    return;
  }

  display_hint("offhand_spotter_simple", timeout, undefined, level.player, endonmessage);
}

function function_f7bf7870e38dcc6(timeout) {
  timeout = default_to(timeout, 12);
  function_7c5679320c7c1fac("spotter_marked", timeout);
}

function function_37f7fc77b17ba731() {
  function_7c5679320c7c1fac("spotter_scope_offhand_raised", undefined);
  level.player waittill("spotter_scope_offhand_raised");
  wait 0.6;
  display_hint("offhand_spotter_commit", undefined, undefined, level.player, "spotter_marked");
}