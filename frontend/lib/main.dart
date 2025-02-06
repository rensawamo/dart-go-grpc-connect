import 'package:eliza/gen/eliza.pb.dart';
import 'package:eliza/transport/grpc_transport.dart';
import 'package:flutter/material.dart';
import 'package:connectrpc/connect.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './gen/eliza.connect.client.dart';

void main() {
  runApp(const ProviderScope(child: ElizaApp()));
}

class ElizaApp extends ConsumerWidget {
  const ElizaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ビルドモードで切り替える
    final transport = ref.read(grpcTransportProvider);

    return MaterialApp(
      title: 'Eliza',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ChatPage(transport: transport),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.transport});
  final Transport transport;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messages = List<({String sentence, bool byUser})>.empty(growable: true);
  final currentSentence = TextEditingController();

  void addMessage(String sentence, bool byUser) {
    setState(() => messages.add((sentence: sentence, byUser: byUser)));
  }

  void send(String sentence) async {
    addMessage(sentence, true);
    final response = await ElizaServiceClient(widget.transport).say(
      SayRequest(sentence: sentence),
    );
    addMessage(response.sentence, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    for (final message in messages)
                      Column(
                        key: ObjectKey(message),
                        children: [
                          if (message.byUser) ...[
                            const Row(
                              children: [
                                Spacer(),
                                Text(
                                  "You",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                Text(
                                  message.sentence,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            )
                          ] else ...[
                            const Row(
                              children: [
                                Text(
                                  "Eliza",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  message.sentence,
                                  textAlign: TextAlign.left,
                                ),
                                const Spacer(),
                              ],
                            )
                          ]
                        ],
                      )
                  ],
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: currentSentence,
                      decoration: const InputDecoration(
                        hintText: 'Write your message...',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final sentence = currentSentence.text;
                      if (sentence.isEmpty) {
                        return;
                      }
                      send(sentence);
                      currentSentence.clear();
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
