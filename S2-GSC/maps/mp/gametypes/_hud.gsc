/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hud.gsc
*********************************************/

func_00D5() {
  level.var_A012 = spawnStruct();
  level.var_A012.var_00C6 = "left";
  level.var_A012.var_01CA = "top";
  level.var_A012.var_0010 = "left";
  level.var_A012.var_0011 = "top";
  level.var_A012.var_01D3 = 0;
  level.var_A012.var_01D7 = 0;
  level.var_A012.var_01D2 = 0;
  level.var_A012.var_00BD = 0;
  level.var_A012.var_21F6 = [];
  level.var_3DD8 = 12;
  level.var_4F52["allies"] = spawnStruct();
  level.var_4F52["axis"] = spawnStruct();
  level.var_76FF = -61;
  level.var_76FE = 0;
  level.var_76FA = 9;
  level.var_76FD = 120;
  level.var_76FC = -75;
  level.var_76FB = 0;
  level.var_76F9 = 0.6;
  level.var_9868 = 32;
  level.var_9865 = 14;
  level.var_9867 = 192;
  level.var_9866 = 8;
  level.var_9864 = 1.65;
  level.var_5F2F = "BOTTOM";
  level.var_5F2E = -90;
  level.var_5F2D = 1.6;
}

func_3DDA(param_00) {
  self.var_15FC = self.var_009B;
  if(isDefined(param_00)) {
    self.var_6085 = min(param_00, 6.3);
  } else {
    self.var_6085 = min(self.var_009B * 2, 6.3);
  }

  self.var_5136 = 2;
  self.var_6C71 = 4;
}

func_3DD9(param_00) {
  self notify("fontPulse");
  self endon("fontPulse");
  self endon("death");
  param_00 endon("disconnect");
  param_00 endon("joined_team");
  param_00 endon("joined_spectators");
  self changefontscaleovertime(self.var_5136 * 0.05);
  self.var_009B = self.var_6085;
  wait(self.var_5136 * 0.05);
  self changefontscaleovertime(self.var_6C71 * 0.05);
  self.var_009B = self.var_15FC;
}