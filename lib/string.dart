class Strings{

  String name,
    illness,
    addUser = "",
    setting = "",
    theme = "",
    exit = "",
    profile = "",
    langs = "",
    currentlangs = "",
    system = "",
    restartNow = "",
    cancel = "",
    hello ="",
    see = "",
    general = "",
    sick ="",
    realname ="",
    msg1 = "",
    ill = "",
    undefined = "",
    msg2 = "",
    dashboard ="",
    routine ="",
    apps ="",
    help = "",
    about ="",
    yes = "",
    deleteacc = "",
    dob = "",
    healthy = "",
    msg3 ="",
    msg4 ="",
    msg5 ="",
    msg6 ="",
    msg7 = "",
    save = "",
    rou = "",
    saved = "",
    canceled ="",
    success ="",
    failed = "",
    delete = "";
  List<String> modes = ["","",""];
  List<String> names;
  
  final List<String> localestr = ['English', 'Indonesia'];

  void lang(int langID){
    if(langID == 0){
      this.addUser = "Add User";
      this.setting = "Setting";
      this.exit = "Exit";
      this.theme = "Dark Mode";
      this.profile = "Profile";
      this.langs = "Language";
      this.currentlangs = localestr[0];
      this.msg1 = "Please Restart the Application";
      this.msg2 = "Change Language?";
      this.restartNow = "Restart Now";
      this.cancel = "Cancel";
      this.hello = "Hello";
      this.see = "Let's See...";
      this.general = "General";
      this.sick = "Sick";
      this.realname = "Name";
      this.ill = "Illness";
      this.undefined ="Undefined";
      this.dashboard = "Dashboard";
      this.routine ="Routine";
      this.apps ="Apps";
      this.help = "Help";
      this.about ="About";
      this.msg3 ="Please input your full name";
      this.yes = "Ok";
      this.deleteacc = "Delete account";
      this.dob = "Date of birth";
      this.healthy = "Healthy";
      this.msg4 = "Are you sure want to delete this account?";
      this.msg5 = "Delete account?";
      this.delete = "Delete";
      this.msg6 = "Delete Routine?";
      this.save = "Save";
      this.rou ="New Routine";
      this.saved = "Saved";
      this.canceled = "Canceled";
      this.success = "Operation Success";
      this.failed = "Operation Failed";
    }else if(langID == 1){
      this.addUser = "Tambah Pengguna";
      this.setting = "Pengaturan";
      this.exit = "Keluar";
      this.theme = "Mode Gelap";
      this.profile = "Profil";
      this.langs = "Bahasa";
      this.currentlangs = localestr[1];
      this.msg1 = "Mohon Restart Aplikasi";
      this.msg2 = "Ganti Bahasa?";
      this.restartNow = "Mulai Ulang";
      this.cancel = "Batal";
      this.hello = "Halo";
      this.see = "Mari kita lihat...";
      this.general = "Umum";
      this.sick = "Sakit";
      this.realname ="Nama";
      this.ill = "Penyakit";
      this.undefined = "Belum diatur";
      this.dashboard ="Dasbor";
      this.routine = "Rutinitas";
      this.apps ="Aplikasi";
      this.about = "Tentang Aplikasi";
      this.help ="Bantuan";
      this.msg3 ="Mohon masukkan nama lengkap anda";
      this.yes = "Ya";
      this.deleteacc = "Hapus akun";
      this.dob = "Tanggal Lahir";
      this.healthy = "Sehat";
      this.msg4 = "Apakah anda yakin ingin menghapus akun ini?";
      this.msg5 = "Hapus akun?";
      this.delete = "Hapus";
      this.msg6 = "Hapus Rutinitas?";
      this.save = "Simpan";
      this.rou = "Rutinitas Baru";
      this.saved = "Disimpan";
      this.canceled = "Dibatalkan";
      this.success = "Operasi Sukses";
      this.failed = "Operasi gagal";
    }
  }
}