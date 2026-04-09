import 'package:dio/dio.dart';

import '../models/command.dart';
import '../models/command_type.dart';
import '../models/queued_command.dart';
import 'base_api.dart';

class CommandsApi extends BaseApi {
  CommandsApi(super.dio);

  Future<List<Command>> getCommands({
    bool? all,
    int? userId,
    int? deviceId,
    int? groupId,
    bool? refresh,
    int? limit,
    int? offset,
    String? keyword,
  }) => guard(() async {
    final params = <String, dynamic>{};
    if (all != null) params['all'] = all;
    if (userId != null) params['userId'] = userId;
    if (deviceId != null) params['deviceId'] = deviceId;
    if (groupId != null) params['groupId'] = groupId;
    if (refresh != null) params['refresh'] = refresh;
    if (limit != null) params['limit'] = limit;
    if (offset != null) params['offset'] = offset;
    if (keyword != null) params['keyword'] = keyword;
    final response = await dio.get<List<dynamic>>(
      '/commands',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => Command.fromJson(e as Map<String, dynamic>))
        .toList();
  });

  Future<Command> createCommand(Command command) => guard(() async {
    final response = await dio.post<Map<String, dynamic>>(
      '/commands',
      data: command.toJson(),
    );
    return Command.fromJson(response.data!);
  });

  Future<Command> updateCommand(int id, Command command) => guard(() async {
    final response = await dio.put<Map<String, dynamic>>(
      '/commands/$id',
      data: command.toJson(),
    );
    return Command.fromJson(response.data!);
  });

  Future<void> deleteCommand(int id) =>
      guard(() async => dio.delete<void>('/commands/$id'));

  /// Returns saved commands supported by the device right now.
  Future<List<Command>> getSendableCommands({required int deviceId}) =>
      guard(() async {
        final response = await dio.get<List<dynamic>>(
          '/commands/send',
          queryParameters: {'deviceId': deviceId},
        );
        return (response.data ?? [])
            .map((e) => Command.fromJson(e as Map<String, dynamic>))
            .toList();
      });

  /// Dispatches a command to a device. Returns the sent [Command] (HTTP 200)
  /// or `null` when the command was queued (HTTP 202).
  ///
  /// Check [sendCommandRaw] if you need the raw 202 queued payload.
  Future<Command> sendCommand(Command command, {int? groupId}) =>
      guard(() async {
        final params = <String, dynamic>{};
        if (groupId != null) params['groupId'] = groupId;
        final response = await dio.post<Map<String, dynamic>>(
          '/commands/send',
          data: command.toJson(),
          queryParameters: params,
        );
        return Command.fromJson(response.data!);
      });

  /// Like [sendCommand] but returns the raw [QueuedCommand] when the server
  /// responds with HTTP 202 (command queued for later delivery).
  Future<Object> sendCommandRaw(Command command, {int? groupId}) =>
      guard(() async {
        final params = <String, dynamic>{};
        if (groupId != null) params['groupId'] = groupId;
        final response = await dio.post<dynamic>(
          '/commands/send',
          data: command.toJson(),
          queryParameters: params,
          options: Options(validateStatus: (s) => s != null && s < 300),
        );
        if (response.statusCode == 202) {
          final data = response.data;
          if (data is List) {
            return data
                .map((e) => QueuedCommand.fromJson(e as Map<String, dynamic>))
                .toList();
          }
          return QueuedCommand.fromJson(response.data as Map<String, dynamic>);
        }
        return Command.fromJson(response.data as Map<String, dynamic>);
      });

  /// Returns available command types for [deviceId].
  Future<List<CommandType>> getCommandTypes({
    int? deviceId,
    bool? textChannel,
  }) => guard(() async {
    final params = <String, dynamic>{};
    if (deviceId != null) params['deviceId'] = deviceId;
    if (textChannel != null) params['textChannel'] = textChannel;
    final response = await dio.get<List<dynamic>>(
      '/commands/types',
      queryParameters: params,
    );
    return (response.data ?? [])
        .map((e) => CommandType.fromJson(e as Map<String, dynamic>))
        .toList();
  });
}
