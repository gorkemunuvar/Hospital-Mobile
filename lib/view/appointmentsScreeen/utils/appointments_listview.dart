import 'package:flutter/cupertino.dart';

import 'appointment_card.dart';

class AppointmentsListView extends StatelessWidget {
  final List<AppointmentCard> appointmentCards;

  AppointmentsListView({this.appointmentCards});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: appointmentCards.length,
      itemBuilder: (context, index) {
        return appointmentCards[index];
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
    );
  }
}
