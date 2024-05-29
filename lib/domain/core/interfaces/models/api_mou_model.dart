class MouResponse {
  bool isValid;
  List<MouData> data;

  MouResponse({required this.isValid, required this.data});

  factory MouResponse.fromJson(Map<String, dynamic> json) {
    return MouResponse(
      isValid: json['is_valid'],
      data:
          (json['data'] as List).map((item) => MouData.fromJson(item)).toList(),
    );
  }
}

class MouData {
  int id;
  String nomorMou;
  String judulMou;
  int jenisDoc;
  String tanggalDibuat;
  String tanggalBerakhir;
  String fileMou;
  String filePath;
  int levelMou;
  KategoriMou kategoriMou;
  int relevansiProdi;
  String status;
  String kerjaSamaDengan;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  LevelDocMou levelDocMou;
  JenisMou jenisMou;
  RelevansiProdiMou relevansiProdiMou;

  MouData({
    required this.id,
    required this.nomorMou,
    required this.judulMou,
    required this.jenisDoc,
    required this.tanggalDibuat,
    required this.tanggalBerakhir,
    required this.fileMou,
    required this.filePath,
    required this.levelMou,
    required this.kategoriMou,
    required this.relevansiProdi,
    required this.status,
    required this.kerjaSamaDengan,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.levelDocMou,
    required this.jenisMou,
    required this.relevansiProdiMou,
  });

  factory MouData.fromJson(Map<String, dynamic> json) {
    return MouData(
      id: json['id'],
      nomorMou: json['nomor_mou'],
      judulMou: json['judul_mou'],
      jenisDoc: json['jenis_doc'],
      tanggalDibuat: json['tanggal_dibuat'],
      tanggalBerakhir: json['tanggal_berakhir'],
      fileMou: json['file_mou'],
      filePath: json['file_path'],
      levelMou: json['level_mou'],
      kategoriMou: KategoriMou.fromJson(json['kategori_mou']),
      relevansiProdi: json['relevansi_prodi'],
      status: json['status'],
      kerjaSamaDengan: json['kerja_sama_dengan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      levelDocMou: LevelDocMou.fromJson(json['level_doc_mou']),
      jenisMou: JenisMou.fromJson(json['jenis_mou']),
      relevansiProdiMou:
          RelevansiProdiMou.fromJson(json['relevansi_prodi_mou']),
    );
  }
}

class KategoriMou {
  int id;
  String namaKategori;
  String keterangan;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  KategoriMou({
    required this.id,
    required this.namaKategori,
    required this.keterangan,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory KategoriMou.fromJson(Map<String, dynamic> json) {
    return KategoriMou(
      id: json['id'],
      namaKategori: json['nama_kategori'],
      keterangan: json['keterangan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }
}

class LevelDocMou {
  int id;
  String namaLevel;
  String keterangan;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  LevelDocMou({
    required this.id,
    required this.namaLevel,
    required this.keterangan,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory LevelDocMou.fromJson(Map<String, dynamic> json) {
    return LevelDocMou(
      id: json['id'],
      namaLevel: json['nama_level'],
      keterangan: json['keterangan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }
}

class JenisMou {
  int id;
  String namaJenis;
  String keterangan;
  String createdAt;
  String updatedAt;

  JenisMou({
    required this.id,
    required this.namaJenis,
    required this.keterangan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JenisMou.fromJson(Map<String, dynamic> json) {
    return JenisMou(
      id: json['id'],
      namaJenis: json['nama_jenis'],
      keterangan: json['keterangan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class RelevansiProdiMou {
  int id;
  String namaProdi;
  dynamic keterangan;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  RelevansiProdiMou({
    required this.id,
    required this.namaProdi,
    required this.keterangan,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory RelevansiProdiMou.fromJson(Map<String, dynamic> json) {
    return RelevansiProdiMou(
      id: json['id'],
      namaProdi: json['nama_prodi'],
      keterangan: json['keterangan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }
}
