class SiteManager
    constructor: ->
        @form = $('#add')
        @list = $('#sites')
        @error = $('#error')
        do @setListeners
        
    setListeners: ->
        @form.on('submit', =>
            if !@form.find('input[type="submit"]').hasClass('disabled')
                do @submitForm
            
            return false
        )
        @list.on('click', 'li button', (e) =>
            @removeSite e
            return false
        )
    
    submitForm: ->
        do @lockPage
        do @clearError
        $.ajax(
            url: '/'
            method: 'POST',
            data:
                domain: @form.find('input[name="domain"]').val()
                path: @form.find('input[name="path"]').val()
            success: (data) =>
                if data.error?
                    do @unlockPage
                    @appendError data.error
            error: =>
                do @checkAvailability
        )
    
    removeSite: (e) ->
        if $(e.target).hasClass('disabled')
            return

        do @lockPage
        
        domain = $(e.target).data('domain')
        $.get("/delete/#{domain}")
        setTimeout(@checkAvailability, 3000)
        
    lockPage: ->
        $(document).find('input, button').addClass('disabled').prop('disabled', true)
    
    unlockPage: ->
        $(document).find('input, button').removeClass('disabled').prop('disabled', false)
    
    appendError: (text) ->
        @error.text text
    
    clearError: ->
        @error.text ''
    
    checkAvailability: ->
        setInterval(->
            $.get('/', ->
                location.href = '/'
            )
        , 1000)
    
new SiteManager

