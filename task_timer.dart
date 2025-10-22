import 'package:flutter/material.dart';
import 'dart:async';

class TaskTimer extends StatefulWidget {
  final DateTime dueDate;

  const TaskTimer({Key? key, required this.dueDate}) : super(key: key);

  @override
  _TaskTimerState createState() => _TaskTimerState();
}

class _TaskTimerState extends State<TaskTimer> {
  late Timer _timer;
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    _calculateTimeLeft();
    _startTimer();
  }

  void _calculateTimeLeft() {
    final now = DateTime.now();
    _timeLeft = widget.dueDate.difference(now);
    if (_timeLeft.isNegative) {
      _timeLeft = const Duration();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _calculateTimeLeft();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _getTimerColor(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _formatDuration(_timeLeft),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getTimerColor() {
    if (_timeLeft.inHours < 1) {
      return Colors.red;
    } else if (_timeLeft.inHours < 24) {
      return Colors.orange;
    }
    return Colors.green;
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}d ${duration.inHours.remainder(24)}h';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ${duration.inSeconds.remainder(60)}s';
    }
    return '${duration.inSeconds}s';
  }
}
