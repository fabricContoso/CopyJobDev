[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "holidaydatacontainer_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "countryOrRegion", DestinationColumnName = "countryOrRegion"], [SourceColumnName = "holidayName", DestinationColumnName = "holidayName"], [SourceColumnName = "normalizeHolidayName", DestinationColumnName = "normalizeHolidayName"], [SourceColumnName = "isPaidTimeOff", DestinationColumnName = "isPaidTimeOff"], [SourceColumnName = "countryRegionCode", DestinationColumnName = "countryRegionCode"], [SourceColumnName = "date", DestinationColumnName = "date"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared holidaydatacontainer = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = WorkspaceId]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = LakehouseId]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "holidaydatacontainer", ItemKind = "Table"]}[Data],
  #"Filtered rows" = Table.SelectRows(#"Navigation 2", each [countryOrRegion] = Region)
in
  #"Filtered rows";
shared WorkspaceId = let
  WorkspaceId = Variable.ValueOrDefault("$(/**/dataflow-Variables/WorkspaceId)", "a8ed1cde-aed9-4be7-b12b-cb1ea5d5c65d")
  in
  WorkspaceId;
shared LakehouseId = let
LakehouseId =
  Variable.ValueOrDefault("$(/\*\*/dataflow-Variables/LakehouseID)",
  "544866e8-0808-4608-8848-161998da5993")
  in
  LakehouseId;
shared Region = let
  Source = Variable.ValueOrDefault("$(/**/dataflow-Variables/Reigon)", "Sweden")
  in
  Source;
shared holidaydatacontainer_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = null]),
  Navigation_1 = Pattern{[workspaceId = "a8ed1cde-aed9-4be7-b12b-cb1ea5d5c65d"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "9f76d76b-1532-46e2-a62a-61d2cb7f3d5a"]}[Data],
  TableNavigation = Navigation_2{[Item = "holidaydatacontainer", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
