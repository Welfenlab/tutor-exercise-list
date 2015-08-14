module.exports = (ko, config) ->
  class ExerciseViewModel
    constructor: (data) ->
      @id = data.id

      @number = data.number
      @dueDate = ko.observable new Date(Date.parse(data.dueDate))

      @points = 2
      @maxPoints = data.tasks.reduce ((previousValue, currentValue) -> previousValue + currentValue.maxPoints), 0

      @formattedDueDate = ko.computed => @dueDate().toLocaleDateString()
      @isOld = ko.computed => @dueDate().getTime() < Date.now()

    show: => config.show @id

  class OverviewPageViewModel
    constructor: ->
      @exercises = ko.observableArray()

      config.getExercises (exercises) =>
        @exercises exercises.map( (e) -> new ExerciseViewModel(e)).sort (a, b) ->
          if a.isOld()
            return if b.isOld() then 0 else 1
          else
            return if b.isOld() then 1 else 0

  viewModel: OverviewPageViewModel
  template: config.html
