/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5bc60484d17fa95c.gsc
*************************************************/

#using script_36f129f8cf15a219;
#using scripts\mp\gametypes\br_ai_gulag;
#using scripts\mp\gametypes\br_dom_gulag;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_twotwo_gulag;
#using scripts\mp\utility\script;
#namespace namespace_d36e6800233f4f97;

function function_dbdca8ca57e8d71d() {
  if(!istrue(level.usegulag)) {
    return;
  }

  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("gulag")) {
    level.usegulag = 0;
    return;
  }

  level.var_43307855f189eb31 = spawnStruct();
  level.var_43307855f189eb31.funcs = [];
  level.var_43307855f189eb31.disabledfeatures = [];
  level.var_43307855f189eb31.enabledfeatures = [];
  level.var_43307855f189eb31.data = [];
  var_eaca66bea536a108 = getDvar(@ "hash_7453401bbd201b1f", "");
  level.var_43307855f189eb31.name = var_eaca66bea536a108 != "" ? var_eaca66bea536a108 : level.gametypebundle.var_eaca66bea536a108;
  level.var_43307855f189eb31.targetname = getDvar(@ "hash_c65716c2a1cc17b2", "gulag");

  if(level.var_43307855f189eb31.targetname == "") {
    level.var_43307855f189eb31.targetname = level.var_43307855f189eb31.name;
  }

  level.var_43307855f189eb31.var_2ad1f292809c28bb = getdvarint(@ "hash_b5f2b14902860071", 0);
  level.var_43307855f189eb31.var_26f27e5acf1b3864 = getdvarint(@ "hash_b2eeb2147b1c0219", 1);
  level.var_43307855f189eb31.var_732a414f682801cc = getdvarint(@ "hash_208847b390767663", 1);
  level.var_43307855f189eb31.var_4749a3b876804ae5 = getdvarint(@ "hash_8da5e76b1e895313", 2);
  level.var_43307855f189eb31.var_6efb9d0afa7efcb2 = getdvarint(@ "hash_5df3ab0ab2df2d97", 0);
  level.var_43307855f189eb31.var_d06b935d7d60de61 = getdvarint(@ "hash_8e9b4afed5d3fc68", 1);
  level.var_43307855f189eb31.dooropentime = getdvarfloat(@ "hash_d54eaab1ef14a6a6", 9);
  level.var_43307855f189eb31.var_61b7b664d529876d = getdvarfloat(@ "hash_d54eaab1ef14a6a6", 9);
  level.var_43307855f189eb31.var_e6b8a86f7f3d8b48 = getdvarint(@ "hash_49244ddb13d62639", 0);
  level.var_43307855f189eb31.var_ec2eaa1a4b68c0cf = getdvarint(@ "hash_2bb3b9b9590667cc", 0);
  level.var_43307855f189eb31.overtimevariation = getdvarint(@ "hash_2c0f39744b369649", 0);
  level.var_43307855f189eb31.forceloadoutindex = getdvarint(@ "hash_9eddca020b3ff8f", -1);
  level.var_43307855f189eb31.var_78a9fe891a9f4771 = getdvarint(@ "hash_ffc2ea8abaddc229", 0);
  level.var_43307855f189eb31.var_cddd2b80c91e5cab = getdvarint(@ "hash_8744d3e7c83ef792", -1);
  level.var_43307855f189eb31.var_10c30e8082648b35 = getdvarint(@ "hash_4b5a8c9f7ae036e4", 0);
  level.var_43307855f189eb31.var_bd9294679812b88 = getdvarint(@ "hash_3498eda80bb80222", 2);
  level.var_43307855f189eb31.var_7ca96b105dd358df = getdvarint(@ "hash_333310f7e9bbcd8e", -1);
  level.var_43307855f189eb31.var_c497886247559b89 = getdvarint(@ "hash_bf016d6c46e99d48", 0);
  level.var_43307855f189eb31.var_a30dc2ea18faa0aa = getdvarint(@ "hash_852c517cfb699e95", 0);
  level.var_43307855f189eb31.var_6712560a5ef54a88 = getdvarint(@ "hash_17ba2e13964efb4a", 0);
  level.var_43307855f189eb31.var_7679335be79f4871 = getDvar(@ "hash_fe58777db4daf820", "");
  level.var_43307855f189eb31.var_b18455b0e6b6e213 = getdvarint(@ "hash_2f58bb09e730f7cd", 2);
  level.var_43307855f189eb31.var_5bc7dbd34df10b08 = getdvarint(@ "hash_820235266e690648", 5);
  level.var_43307855f189eb31.gasspawning = getdvarint(@ "hash_2541a23b20690d5b", 0);
  level.var_43307855f189eb31.var_b1985d454f9b2200 = getdvarint(@ "hash_50d3c409b198c15b", 13);
  level.var_43307855f189eb31.var_186b191e239abc1c = getdvarint(@ "hash_e5b993b16925ff4d", 0);
  level.var_43307855f189eb31.var_ef02a6ec3343c9bd = getdvarint(@ "hash_276d595245120a57", 0);
  level.var_43307855f189eb31.var_41ba817a6aa8ea0a = getdvarint(@ "hash_9e66b59fc89ffbef", 0);
  level.var_43307855f189eb31.var_82fedf664ad855eb = getdvarint(@ "hash_8b7830621f9f5ef5", 0);
  level.var_43307855f189eb31.var_5a6e1bcee6e4a7f1 = getdvarint(@ "hash_10fca2d678cb8faf", 1);
  level.var_43307855f189eb31.var_cadc8d24186a8a91 = getdvarint(@ "hash_8bb712d4f65ed1c8", 1);

  if(level.var_43307855f189eb31.var_c497886247559b89) {
    level.var_43307855f189eb31.dooropentime = getdvarfloat(@ "hash_d54eaab1ef14a6a6", 9);
  } else {
    level.var_43307855f189eb31.dooropentime = getdvarfloat(@ "hash_d54eaab1ef14a6a6", 13);
  }

  level.var_43307855f189eb31.matchstartweapons = getdvarint(@ "hash_23b784d6499a68f3", 5);
  level.var_43307855f189eb31.allowfriendlyfire = getdvarint(@ "hash_7733d088ade14995", 0);
  level.var_43307855f189eb31.var_d8acf770bb690e88 = getdvarint(@ "hash_540f81ab0aacd7c5", 2000);
  level.var_43307855f189eb31.var_d5e82d0c08288a76 = getDvar(@ "hash_2728413178b1ee5e", "12000, 5000, 13000,4500, 15000,4000, 17000,3500, 19000,3000, 22000,2500, 30000,2000, 40000,1700, 50000,1400, 55000,1000, 60000,0");
  level.var_43307855f189eb31.var_f61587ba0e14efb3 = getDvar(@ "hash_1a6c0b0c4e2a9b59", "7, 5000,6, 4400, 5,3600, 4,2800, 3,2100, 2,1400, 1,700,0,0");
  level.var_43307855f189eb31.var_f38668696712bbec = getDvar(@ "hash_1a6c0b0c4e2a9b59", "100, 2500, 90, 2000, 80, 1500, 70, 1000, 60, 800,50, 600,40, 400,30, 300,20, 200,10, 100,0,0");
  level.var_43307855f189eb31.var_a3c8a88ee8f693b1 = getDvar(@ "hash_1a6c0b0c4e2a9b59", "0, 2500, 40, 2000, 80, 1500, 120,1000, 160,800,200,600,240,400,260,300,280,200,300,100,340,0");
  level.var_43307855f189eb31.var_d1562ade1a147c53 = getDvar(@ "hash_1a6c0b0c4e2a9b59", "2499,0,2500, 1,4000, 2,5300, 3,7500, 4,11000,5");
  level.var_43307855f189eb31.var_13a255f6d4f217b5 = getDvar(@ "hash_b3919ec55466c612", "");
  level.var_43307855f189eb31.var_3b156be10b96edb9 = getdvarint(@ "hash_d7503717efc09613", 1);
  level.var_43307855f189eb31.var_2928dfb3a48d00b3 = getdvarint(@ "hash_284579e86ada418", 0);
  level.var_43307855f189eb31.var_592faf90ea5616f5 = getdvarint(@ "hash_809e2b6a0ae176ee", 0);
  level.var_43307855f189eb31.var_2f9ae625d3d6ef89 = getdvarint(@ "hash_34c131283285e0c3", 1);
  level.var_43307855f189eb31.var_1a56fc9a83d19e68 = getdvarint(@ "hash_e77b35ec14c97e2a", 1);

  if(level.var_43307855f189eb31.var_13a255f6d4f217b5 != "") {
    var_465c2f36e6e2e41a = strtok(level.var_43307855f189eb31.var_13a255f6d4f217b5, " ");
    var_ed112336a49b6b8c = [];

    foreach(index in var_465c2f36e6e2e41a) {
      var_ed112336a49b6b8c[var_ed112336a49b6b8c.size] = int(index);
    }

    level.var_43307855f189eb31.var_13a255f6d4f217b5 = var_ed112336a49b6b8c;
  }

  switch (level.var_43307855f189eb31.name) {
    case #"hash_4de6d2f1420f5c6":
      scripts\mp\gametypes\br_ai_gulag::function_4a0935954bbfdeb1();
      break;
    case #"hash_9c45f4b9f1458bf7":
      namespace_86576387a1a88d::function_c99f924fa8207378();
      break;
    case #"hash_e008e31cba81b654":
      scripts\mp\gametypes\br_dom_gulag::function_53088602ea68d303();
      break;
    case #"hash_7eae9f0c936966e0":
      scripts\mp\gametypes\br_twotwo_gulag::function_b7a198c3929006d7();
      break;
    case #"":
      return;
    default:
      assertmsg("<dev string:x1c>" + level.var_43307855f189eb31.name + "<dev string:x5b>");
      break;
  }
}

function function_1980065ce4dc067b() {
  if(!isDefined(level.var_43307855f189eb31) || isDefined(level.var_43307855f189eb31.name) && level.var_43307855f189eb31.name == "") {
    return false;
  }

  return true;
}

function function_c9fa720726fab853(funcname, function) {
  if(isDefined(level.var_43307855f189eb31.funcs[funcname])) {
    scripts\mp\utility\script::demoforcesre("registerGulagVariationFunc already has " + funcname + " defined.");
  }

  level.var_43307855f189eb31.funcs[funcname] = function;
}

function function_3cceb052d780fef1(funcname, param1, param2) {
  if(isDefined(level.var_43307855f189eb31) && isDefined(level.var_43307855f189eb31.funcs[funcname])) {
    if(isDefined(param2)) {
      return [[level.var_43307855f189eb31.funcs[funcname]]](param1, param2);
    }

    if(isDefined(param1)) {
      return [[level.var_43307855f189eb31.funcs[funcname]]](param1);
    }

    return [[level.var_43307855f189eb31.funcs[funcname]]]();
  }
}

function function_cfe304859f30e747(funcname) {
  return isDefined(level.var_43307855f189eb31) && isDefined(level.var_43307855f189eb31.funcs[funcname]);
}

function function_8debf0c616bf9480(featurename) {
  level.var_43307855f189eb31.disabledfeatures[featurename] = 1;
}

function function_2c600e5e9a2cf916(featurename) {
  return !isDefined(level.var_43307855f189eb31) || istrue(level.var_43307855f189eb31.disabledfeatures[featurename]);
}

function function_f6796774d7a9535b(featurename) {
  level.var_43307855f189eb31.enabledfeatures[featurename] = 1;
}

function function_27c68dd3e26c23db(featurename) {
  return isDefined(level.var_43307855f189eb31) && istrue(level.var_43307855f189eb31.enabledfeatures[featurename]);
}

function function_b687bbe12d7cd2b9(dataref, data) {
  level.var_43307855f189eb31.data[dataref] = data;
}

function function_8c6b39e007fc3132(dataref) {
  return level.var_43307855f189eb31.data[dataref];
}