enum TrucoStatus {
  NOT_REQUESTED,
  REQUESTED_3_POINTS,
  REQUESTED_6_POINTS,
  REQUESTED_9_POINTS,
  REQUESTED_12_POINTS,
  ACCEPTED,
  REFUSED
}

extension TrucoStatusExtension on TrucoStatus {
  int pointsAwarded() {
    switch (this) {
      case TrucoStatus.REQUESTED_3_POINTS:
        return 3;
      case TrucoStatus.REQUESTED_6_POINTS:
        return 6;
      case TrucoStatus.REQUESTED_9_POINTS:
        return 9;
      case TrucoStatus.REQUESTED_12_POINTS:
        return 12;
      default:
        return 0;
    }
  }
}
