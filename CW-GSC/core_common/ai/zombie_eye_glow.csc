/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie_eye_glow.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zombie_eye_glow;

function private autoexec __init__system__() {
  system::register(#"zombie_eye_glow", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "zombie_eye_glow", 1, 3, "int", &zombie_eye_glow, 0, 0);
}

function private postinit() {}

function zombie_eye_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self good_barricade_damaged(fieldname);

  if(bwastimejump > 0) {
    if(isDefined(self.var_a63f638a)) {
      self.var_12b59dee = self.var_a63f638a;
    } else {
      switch (bwastimejump) {
        case 2:
          self.var_12b59dee = "rob_zm_eyes_blue";
          break;
        case 3:
          self.var_12b59dee = "rob_zm_eyes_green";
          break;
        case 4:
          self.var_12b59dee = "rob_zm_eyes_orange";
          break;
        case 5:
          self.var_12b59dee = "rob_zm_eyes_red";
          break;
        default:
          self.var_12b59dee = "rob_zm_eyes_orange";
          break;
      }
    }

    if(isDefined(self.var_d5fd20ef)) {
      var_d40cd873 = self.var_d5fd20ef;
    } else {
      switch (bwastimejump) {
        case 2:
          var_d40cd873 = "wz/fx8_zombie_eye_glow_blue_wz";
          break;
        case 3:
          var_d40cd873 = "wz/fx8_zombie_eye_glow_green_wz";
          break;
        case 4:
          var_d40cd873 = "zm_ai/fx8_zombie_eye_glow_orange";
          break;
        case 5:
          var_d40cd873 = "zm_ai/fx8_zombie_eye_glow_red";
          break;
        default:
          var_d40cd873 = "zm_ai/fx8_zombie_eye_glow_orange";
          break;
      }
    }

    self function_fe127aaf(fieldname, self.var_12b59dee, var_d40cd873);
  }
}

function good_barricade_damaged(localclientnum) {
  if(isDefined(self.var_12b59dee)) {
    self stoprenderoverridebundle(self.var_12b59dee, "j_head");
    self.var_12b59dee = undefined;
  }

  if(isDefined(self.var_3231a850)) {
    stopfx(localclientnum, self.var_3231a850);
    self.var_3231a850 = undefined;
  }
}

function private function_fe127aaf(localclientnum, var_ee6bcd51, str_fx) {
  if(isDefined(var_ee6bcd51)) {
    self playrenderoverridebundle(var_ee6bcd51, "j_head");
    self.var_12b59dee = var_ee6bcd51;
  }

  if(isDefined(str_fx)) {
    if(isDefined(self.var_f87f8fa0)) {
      self.var_3231a850 = util::playFXOnTag(localclientnum, str_fx, self, self.var_f87f8fa0);
      return;
    }

    self.var_3231a850 = util::playFXOnTag(localclientnum, str_fx, self, "j_eyeball_le");
  }
}

function function_3a020b0f(localclientnum, var_ee6bcd51 = "rob_zm_eyes_orange", str_fx = "zm_ai/fx8_zombie_eye_glow_orange") {
  self good_barricade_damaged(localclientnum);
  self function_fe127aaf(localclientnum, var_ee6bcd51, str_fx);
}