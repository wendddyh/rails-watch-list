 <div class="col-12 col-sm-6">
      <h3>Reviews</h3>
      <% if @list.reviews.empty? %>
        <small><em class="text-muted">Be the first one to review this list</em></small>
      <% end %>
      <% @list.reviews.each do |review| %>
        <div>
          <% review.rating.times do %>
            <i class="fas fa-star star-yellow"></i>
          <% end %>
          <small><em class="text-muted"><%= distance_of_time_in_words_to_now(review.created_at) %> ago</em></small>
          <p class="mb-0"><%= review.comment %></p>
        </div>
        <hr>
      <% end %>
    </div>
