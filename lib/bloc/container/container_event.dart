part of 'container_bloc.dart';

@immutable
abstract class ContainerEvent {
  const ContainerEvent();
}

class GetContainer extends ContainerEvent {
  final String id;
  const GetContainer(this.id);
}

class UpdateContainer extends ContainerEvent {
  final String id;
  final Container container;
  const UpdateContainer(this.id, this.container);
}

class CreateContainer extends ContainerEvent {
  final Container container;
  const CreateContainer(this.container);
}

class DeleteContainer extends ContainerEvent {
  final String id;
  const DeleteContainer(this.id);
}

class GetContainersForDriver extends ContainerEvent {
  final String driverId;
  const GetContainersForDriver(this.driverId);
}

class GetContainersForTenant extends ContainerEvent {
  final String tenantId;
  const GetContainersForTenant(this.tenantId);
}
