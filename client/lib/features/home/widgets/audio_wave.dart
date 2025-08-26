import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AudioWave extends StatefulWidget {
  final String audioPath;
  const AudioWave({super.key, required this.audioPath});

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController playerController = PlayerController();
  bool _isPlaying = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _preparePlayer();
  }

  Future<void> _preparePlayer() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await playerController.preparePlayer(path: widget.audioPath);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error preparing audio: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  Future<void> playAndPause() async {
    if (_isLoading) return; // Prevent multiple calls while loading

    try {
      setState(() {
        _isLoading = true;
      });

      if (_isPlaying) {
        await playerController.pausePlayer();
        setState(() {
          _isPlaying = false;
        });
      } else {
        await playerController.startPlayer(forceRefresh: true);
        setState(() {
          _isPlaying = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error playing audio: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _isLoading ? null : playAndPause,
          icon: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : _isPlaying
                  ? const Icon(Icons.pause_outlined)
                  : const Icon(Icons.play_arrow_outlined),
        ),
        Expanded(
          child: AudioFileWaveforms(
            size: const Size(double.maxFinite, 100),
            playerController: playerController,
            playerWaveStyle: const PlayerWaveStyle(
                backgroundColor: Colors.transparent,
                liveWaveColor: Pallete.gradient2,
                fixedWaveColor: Pallete.borderColor,
                spacing: 10),
          ),
        ),
      ],
    );
  }
}
