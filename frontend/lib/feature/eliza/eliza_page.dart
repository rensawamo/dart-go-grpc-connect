import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/gen/eliza/v1/eliza.connect.client.dart';
import 'package:frontend/core/gen/eliza/v1/eliza.pb.dart';
import 'package:frontend/core/provider/transport.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends ConsumerState<ChatPage> {
  final messages = List<({String sentence, bool byUser})>.empty(growable: true);
  final currentSentence = TextEditingController();

  void addMessage(String sentence, {required bool byUser}) {
    setState(() => messages.add((sentence: sentence, byUser: byUser)));
  }

  Future<void> call(String sentence) async {
    addMessage(sentence, byUser: true);
    try {
      final response = await ElizaServiceClient(
        ref.read(grpcTransportProvider()),
      ).say(
        SayRequest(sentence: sentence),
      );
      addMessage(response.sentence, byUser: false);
    } on Exception catch (e) {
      addMessage(e.toString(), byUser: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
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
                                  'You',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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
                            ),
                          ] else ...[
                            const Row(
                              children: [
                                Text(
                                  'Eliza',
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
                            ),
                          ],
                        ],
                      ),
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
                      call(sentence);
                      currentSentence.clear();
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
