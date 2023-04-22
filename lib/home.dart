import 'package:flutter/material.dart';
import 'package:gpt_dalle/feature_box.dart';
import 'package:gpt_dalle/pallete.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "KINGS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 13),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Pallete.assistantCircleColor),
                  ),
                ),
                Center(
                  child: Container(
                    height: 170,
                    width: 170,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/robot.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 05),
              margin:
                  const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 01),
              decoration: BoxDecoration(
                border: Border.all(color: Pallete.borderColor),
                borderRadius:
                    BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Good Morning, what task can I do for you?",
                  style: TextStyle(
                      color: Pallete.mainFontColor,
                      fontSize: 20,
                      fontFamily: 'Cera-Pro'),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10, left: 31),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Here are few things to know.",
                style: TextStyle(
                  fontFamily: 'Cera-Pro',
                  color: Pallete.mainFontColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: const [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'ChatGPT',
                  descriptionText:
                      "Experience the future of technology with our revolutionary AI-powered app.",
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: 'DALL-E',
                  descriptionText:
                      "Unleash your creativity with our AI image generator.",
                ),
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: 'Smart Voice Assistance',
                  descriptionText:
                      "Make your life easier with our AI-powered voice assistant.",
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 18, right: 20),
        child: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: Icon(Icons.mic),
        ),
      ),
    );
  }
}
