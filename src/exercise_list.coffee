module.exports = (ko) ->
  class ExerciseViewModel
    constructor: (data) ->
      @id = data.id

      @number = data.number
      @dueDate = ko.observable new Date(Date.parse(data.dueDate))

      @points = 2
      @maxPoints = data.tasks.reduce ((previousValue, currentValue) -> previousValue + parseInt(currentValue.maxPoints)), 0

      @formattedDueDate = ko.computed => @dueDate().toLocaleDateString()
      @isOld = ko.computed => @dueDate().getTime() < Date.now()

  class OverviewPageViewModel
    constructor: ->
      @exercises = ko.observableArray()

      @getExercises (exercises) =>
        @exercises exercises.map((e) => @createExerciseViewModel(e)).sort (a, b) ->
          if a.isOld()
            return if b.isOld() then 0 else 1
          else
            return if b.isOld() then 1 else 0

    createExerciseViewModel: (e) -> new ExerciseViewModel(e)


  ExerciseViewModel: ExerciseViewModel
  OverviewPageViewModel: OverviewPageViewModel
