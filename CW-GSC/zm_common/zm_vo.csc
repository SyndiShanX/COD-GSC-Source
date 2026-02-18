/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_vo.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace zm_vo;

function private autoexec __init__system__() {
  system::register(#"zm_vo", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("zm_hud.commander_speaking", #"zm_hud", #"commander_speaking", 1, 5, "int", undefined, 0, 0);
  level.var_4edd846 = &function_d1711916;
}

function private function_d1711916(var_332276f2, dialogkey) {
  switch (dialogkey) {
    case # "hash_5f3108a8ed351288":
      return var_332276f2.var_57aeff94;
    case # "hash_5e2a1ca8dc76be67":
      return var_332276f2.var_1d7e6d4f;
    case # "hash_e98c059b131f86c":
      return var_332276f2.var_78a321f1;
    case # "hash_2e657370192514b5":
      return var_332276f2.var_8cf2fd05;
    case # "hash_4e2a478df2a81e8c":
      return var_332276f2.var_6275013;
    case # "hash_4990f9c23cc9c32a":
      return var_332276f2.var_4e454b1f;
    case # "hash_7bc0702612f442b9":
      return var_332276f2.var_415efa99;
    case # "hash_4e930dbe494975b4":
      return var_332276f2.var_675f3003;
    case # "hash_5e9f5daa234fe730":
      return var_332276f2.var_fc81fdbb;
    case # "hash_51d31303312306d":
      return var_332276f2.var_c24b2eea;
    case # "hash_69eda3d15a6035ab":
      return var_332276f2.var_ead40107;
    case # "hash_2e354b187fdbfbbc":
      return var_332276f2.var_26b25ec0;
    case # "hash_49f4ae06ae4af262":
      return var_332276f2.var_e6843753;
    case # "hash_76483333c5c6984":
      return var_332276f2.var_8cf57938;
    case # "hash_14f8f2f4fa732dbd":
      return var_332276f2.var_da554fd6;
    case # "hash_4542da19e0c104c":
      return var_332276f2.var_de5c6530;
    case # "hash_5fc866a41152b3c":
      return var_332276f2.var_a5d46693;
    case # "hash_5b20033c44a4321f":
      return var_332276f2.var_29e91c40;
    case # "zmpingraygun":
      return var_332276f2.zmpingraygun;
    case # "zmpingwonderweapongeneric":
      return var_332276f2.zmpingwonderweapongeneric;
    case # "zmpingcymbalmonkey":
      return var_332276f2.zmpingcymbalmonkey;
    case # "hash_db5b175bd794f60":
      return var_332276f2.var_dbfd0b22;
    case # "zmpingitemsalvage":
      return var_332276f2.zmpingitemsalvage;
    case # "zmpingitemaetherium":
      return var_332276f2.zmpingitemaetherium;
    case # "zmpingitemintel":
      return var_332276f2.zmpingitemintel;
    case # "zmpingitemquest":
      return var_332276f2.zmpingitemquest;
    case # "hash_307d328d2ca73346":
      return var_332276f2.var_87856536;
    case # "zmpingperkcan":
      return var_332276f2.zmpingperkcan;
    case # "hash_3c46000cdd88c6a1":
      return var_332276f2.var_f35b9f76;
    case # "hash_5605b2abdf38cd4":
      return var_332276f2.var_ea4e2490;
    case # "hash_22f552b15fc207f8":
      return var_332276f2.var_5030cbb3;
    case # "hash_1aadb875c07be53a":
      return var_332276f2.var_6a9e0dd7;
    case # "hash_33fa52ed652faf8a":
      return var_332276f2.var_3badb1da;
    case # "hash_35f32b2271ef6ed7":
      return var_332276f2.var_15fd8202;
    case # "hash_462ae51bbab3172a":
      return var_332276f2.var_b22401a2;
    case # "hash_13b63b8343516b9e":
      return var_332276f2.var_aa5adc89;
    case # "hash_68784da81f2a99f7":
      return var_332276f2.var_e70ab1f;
    case # "hash_4df32dcf844b0659":
      return var_332276f2.var_833c7654;
    case # "hash_db9d5c95dfea201":
      return var_332276f2.var_a07153d7;
    case # "hash_504ad9537b38881f":
      return var_332276f2.var_dc4f7a61;
    case # "hash_2a901c3db306ba24":
      return var_332276f2.var_e63f226f;
    case # "hash_25d360e4ab517722":
      return var_332276f2.var_ee31533f;
    case # "hash_23e7594539b63cb8":
      return var_332276f2.var_813486d3;
    case # "hash_365549a15c5bde23":
      return var_332276f2.var_63b4674c;
    case # "hash_7355d2a605e99ad6":
      return var_332276f2.var_c3e62e0e;
    case # "hash_f4743ddde12c80c":
      return var_332276f2.var_7f02b6c7;
    case # "hash_3321e0bf2e424c30":
      return var_332276f2.var_c74169bf;
    case # "hash_3580f779bbcaa04d":
      return var_332276f2.var_5ede0944;
    case # "hash_75c2910f28185f25":
      return var_332276f2.var_6577839f;
    case # "hash_2238f6ae2f9c8847":
      return var_332276f2.var_c150e63a;
    case # "hash_34a0c6f7267b8ba5":
      return var_332276f2.var_dd1d58bf;
    case # "hash_73fd41d7b25c7854":
      return var_332276f2.var_861c8fa7;
  }
}