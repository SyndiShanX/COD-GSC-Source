/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\playercards.gsc
***********************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);

    if(!isai(var_0)) {
      var_0.playercardpatch = var_0 getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_B6A70683C247D8D0");
      var_0.playercardpatchbacking = var_0 getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_B20C0D41A034C6240D0B529A13F0AC");
      var_0.playercardbackground = var_0 getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_8BE70B1557E262E0923D4338E7");
    }
  }
}