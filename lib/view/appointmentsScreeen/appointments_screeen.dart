import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../states/getx_my_appointments.dart';
import '../utils/my_appbar.dart';
import 'utils/appointment_card.dart';
import 'utils/appointments_listview.dart';

class AppointmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MyAppBar(
          title: 'appointmentsPage_header'.tr,
          hasBackButton: true,
          tabbar: _TabBar(),
        ),
        body: const Padding(
          padding: const EdgeInsets.all(12.0),
          child: const TabBarView(
            children: [
              _ActiveAppointments(),
              _PastAppointments(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabBar extends TabBar {
  _TabBar({Key key})
      : super(
          key: key,
          tabs: [
            Tab(
              child: Text('appointmentsPage_activeTab'.tr,
                  style: TextStyle(/*fontFamily: 'Rotunda',*/ fontWeight: FontWeight.bold)),
            ),
            Tab(
              child: Text('appointmentsPage_pastTab'.tr,
                  style: TextStyle(/*fontFamily: 'Rotunda',*/ fontWeight: FontWeight.bold)),
            ),
          ],
        );
}

class _ActiveAppointments extends StatelessWidget {
  const _ActiveAppointments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetxMyAppointments>(builder: (c) {
      if (c.isActiveAppointmentsLoading) {
        return Center(child: CircularProgressIndicator());
      }

      if (c.activeAppointments == null || c.activeAppointments.isEmpty) {
        return Center(
            child: Text('appointmentsPage_noActiveAppointment'.tr, style: TextStyle(fontWeight: FontWeight.bold)));
      }

      final appointmentCards = c.activeAppointments.map((appointment) => AppointmentCard(appointment)).toList();
      return AppointmentsListView(appointmentCards: appointmentCards);
    });
  }
}

class _PastAppointments extends StatelessWidget {
  const _PastAppointments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetxMyAppointments>(builder: (c) {
      if (c.isPastAppointmentsLoading) {
        return Center(child: CircularProgressIndicator());
      }

      if (c.pastAppointments == null || c.pastAppointments.isEmpty) {
        return Center(
            child: Text('appointmentsPage_noPastAppointment'.tr, style: TextStyle(fontWeight: FontWeight.bold)));
      }

      final appointmentCards =
          c.pastAppointments.map((appointment) => AppointmentCard(appointment, isActive: false)).toList();
      return AppointmentsListView(appointmentCards: appointmentCards);
    });
  }
}
