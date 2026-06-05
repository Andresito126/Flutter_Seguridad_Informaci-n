class MessageDto {
  final String message;

  MessageDto({
    required this.message,
  });

  MessageDto.fromJson(Map<String, dynamic> json)
    :
      message = json['message'];
}